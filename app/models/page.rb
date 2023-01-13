# frozen_string_literal: true

class Page < ApplicationRecord
  belongs_to :story
  has_one_attached :image

  def next_page
    @next_page ||= Page.find_by(story_id:, number: number + 1)
  end

  def prev_page
    @prev_page ||= Page.find_by(story_id:, number: number - 1)
  end

  def broadcast_image
    broadcast_update_to self, partial: 'pages/image', locals: { page: self }, target: 'image-wrapper'
  end
end
