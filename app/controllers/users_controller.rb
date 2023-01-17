# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user, except: %i[new create]
  include Pagy::Backend

  def show
    @pagy, @stories = pagy(current_user.stories.order(created_at: :desc))
  end

  def new
    redirect_to dashboard_path and return if current_user

    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:notice] = I18n.t('user_created_successfully')
      login(@user)
      redirect_to settings_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = current_user

    if @user.update(update_user_params.compact)
      flash[:notice] = I18n.t('user_updated_successfully')
      redirect_to dashboard_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.destroy
      flash[:alert] = I18n.t('user_deleted_successfully')
      logout
    else
      render :show, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end

  def update_user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :open_ai_token)
  end
end
