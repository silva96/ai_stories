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
    client.images.generate(
      parameters: {
        prompt: "#{page.story.image_style} photo for a kid's book about this scene: #{page.content}", n: 1
      }
    )
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
