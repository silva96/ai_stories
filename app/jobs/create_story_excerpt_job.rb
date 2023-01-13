# frozen_string_literal: true

class CreateStoryExcerptJob < ApplicationJob
  queue_as :default

  def perform(story_id)
    story = Story.find(story_id)
    return unless story.pages.any?

    create_excerpt(story)
    CreateStoryTitleJob.perform_later(story_id)
  end

  private

  def create_excerpt(story)
    response = create_excerpt_content(story)
    story.update(excerpt: response['choices'][0]['text'].strip)
  end

  def create_excerpt_content(story)
    client = OpenAI::Client.new
    story_content = story.pages.order(number: :asc).pluck(:content).join("\n\n")

    client.completions(
      parameters: {
        model: 'text-davinci-003',
        prompt: "#{story_content}\nTl;dr:",
        max_tokens: (DAVINCI_MAX_TOKENS - story_content.size)
      }
    )
  end
end
