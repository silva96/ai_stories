# frozen_string_literal: true

class StoriesController < ApplicationController
  def index
    @stories = Story.all.order(created_at: :desc)
  end

  def show
    @story = Story.find(params[:id])
    redirect_to new_story_path unless @story
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(story_params)

    if @story.save
      redirect_to story_path(@story)
    else
      render :new
    end
  end

  private

  def story_params
    params.require(:story).permit(:main_character, :secondary_character, :villian, :image_style, :extra_details)
  end
end
