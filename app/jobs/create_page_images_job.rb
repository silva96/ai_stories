# frozen_string_literal: true

require 'open-uri'

class CreatePageImagesJob < ApplicationJob
  queue_as :default

  def perform(story_id, page_id)
    page = Page.find_by(id: page_id, story_id:)
    page.update(generating_image: true)
    response = create_image(page)
    update_image(page, page_id, response, story_id)
    page.broadcast_image
  end

  private

  def create_image(page)
    client = OpenAI::Client.new
    prompt = "Create a #{page.story.image_style} illustration for a kid's book " \
             "representing the following scene:\n\n #{page.content}"
    client.images.generate(parameters: { prompt:, n: 1 })
  end

  def update_image(page, page_id, response, story_id)
    page.update(
      image: {
        io: URI.parse(response['data'][0]['url']).open,
        filename: "story_#{story_id}_page_#{page_id}.png"
      }, generating_image: false
    )
  end
end
