# frozen_string_literal: true

class CreateStoryTitleJob < ApplicationJob
  queue_as :default

  def perform(story_id:, current_user_id:)
    user = User.find(current_user_id)
    return if user.open_ai_token.blank?

    @client = OpenAI::Client.new(access_token: user.open_ai_token)

    story = Story.find(story_id)
    return if story.excerpt.blank?

    create_title(story)
  end

  def create_title(story)
    response = create_title_content(story)
    story.update(title: response['choices'][0]['text'].strip)
  end

  def create_title_content(story)
    prompt = "Create a 5 to 8 words title for a book about this: \n\n#{story.excerpt}"
    @client.completions(
      parameters: { model: 'text-davinci-003', prompt:, max_tokens: (200 + prompt.size) }
    )
  end
end
