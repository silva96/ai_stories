# frozen_string_literal: true

class CreateStoryPagesJob < ApplicationJob
  queue_as :default

  def perform(story_id:, current_user_id:)
    user = User.find(current_user_id)
    return if user.open_ai_token.blank?

    @client = OpenAI::Client.new(access_token: user.open_ai_token)
    story = Story.find(story_id)
    story.pages.destroy_all if story.pages.any?

    create_pages(story)
    story.broadcast_pages
    enqueue_subsequent_jobs(story:, story_id:, current_user_id:)
  end

  private

  def enqueue_subsequent_jobs(story:, story_id:, current_user_id:)
    CreateStoryExcerptJob.perform_later(story_id:, current_user_id:)
    CreatePageImagesJob.perform_later(story_id:, page_id: story.pages.first.id, current_user_id:)
    CreatePageImagesJob.perform_later(story_id:, page_id: story.pages.second.id, current_user_id:)
  end

  def create_pages(story)
    response = create_pages_content(story)
    index = 1
    response['choices'][0]['text'].gsub("\n\n", "\n").split("\n").each do |text|
      if text.strip.size > 10
        story.pages << Page.new(content: text.strip, number: index)
        index += 1
      end
    end
    story.save
  end

  def create_pages_content(story)
    @client.completions(
      parameters: {
        model: 'text-davinci-003',
        prompt: story.prompt,
        max_tokens: (DAVINCI_MAX_TOKENS - story.prompt.size)
      }
    )
  end
end
