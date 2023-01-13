# frozen_string_literal: true

class CreateStoryPagesJob < ApplicationJob
  queue_as :default

  def perform(story_id)
    story = Story.find(story_id)
    story.pages.destroy_all if story.pages.any?

    create_pages(story)
    story.broadcast_pages
    CreateStoryExcerptJob.perform_later(story_id)
    CreatePageImagesJob.perform_later(story_id, story.pages.first.id)
    CreatePageImagesJob.perform_later(story_id, story.pages.second.id)
  end

  private

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
    client = OpenAI::Client.new

    client.completions(
      parameters: {
        model: 'text-davinci-003',
        prompt: story.prompt,
        max_tokens: (DAVINCI_MAX_TOKENS - story.prompt.size)
      }
    )
  end
end
