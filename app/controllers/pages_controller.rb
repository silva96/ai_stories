# frozen_string_literal: true

class PagesController < ApplicationController
  def show
    @page = Page.find_by(story_id: params[:story_id].to_i, number: params[:id])
    return unless needs_to_create_image?

    CreatePageImagesJob.perform_later(@page.story_id, @page.next_page.id)
  end

  private

  def needs_to_create_image?
    @page.next_page.present? && !@page.next_page.image.attached? && !@page.next_page.generating_image?
  end
end
