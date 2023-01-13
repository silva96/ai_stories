# frozen_string_literal: true

class CreateStoryTitleJob < ApplicationJob
  queue_as :default

  def perform(story_id)
    story = Story.find(story_id)
    return if story.excerpt.blank?

    create_title(story)
  end

  def create_title(story)
    response = create_title_content(story)
    story.update(title: response['choices'][0]['text'].strip)
  end

  def create_title_content(story)
    client = OpenAI::Client.new
    prompt = "Create a 5 to 8 words title for a book about this: \n\n#{story.excerpt}"
    client.completions(
      parameters: { model: 'text-davinci-003', prompt:, max_tokens: (DAVINCI_MAX_TOKENS - prompt.size) }
    )
  end
end
