# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :authenticate_user, only: %i[new create destroy]
  include Pagy::Backend

  def index
    @pagy, @stories = pagy(Story.includes(:user).all.order(created_at: :desc))
  end

  def show
    @story = Story.find(params[:id].to_i)
    redirect_to new_story_path unless @story
  end

  def new
    redirect_to settings_path, alert: t('you_need_api_token') and return if current_user.open_ai_token.blank?

    @story = current_user.stories.new
  end

  def create
    @story = current_user.stories.build(story_params)

    if @story.save
      redirect_to story_path(@story)
    else
      render :new
    end
  end

  def destroy
    @story = current_user.stories.find(params[:id])
    @story.destroy
    redirect_to dashboard_path
  end

  private

  def story_params
    params.require(:story).permit(:main_character, :secondary_character, :villain, :image_style, :extra_details)
  end
end
