# frozen_string_literal: true

class Story < ApplicationRecord
  has_many :pages, dependent: :destroy
  after_create_commit :create_pages

  def prompt
    @prompt ||= "Write a kids story with the following characters and details:\n" \
                "Main character: #{main_character}\n" \
                "Secondary characters: #{secondary_character}\n" \
                "Villain: #{villain}\n" \
                "Details: #{extra_details}\n" \
                'Please provide 20 paragraphs, no longer than 4 lines each one. Do not enumerate them'
  end

  def broadcast_pages
    broadcast_update_to self, partial: 'stories/story', locals: { page: self }, target: 'story-wrapper'
  end

  def to_param
    [id, title.parameterize].join('-')
  end

  private

  def create_pages
    CreateStoryPagesJob.perform_later(id)
  end
end
