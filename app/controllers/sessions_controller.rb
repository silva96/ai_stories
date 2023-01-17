# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    redirect_to dashboard_path and return if current_user

    @user = User.new
  end

  def create
    user = User.find_by(username: params[:username])

    if user&.authenticate(params[:password])
      login(user)
      redirect_to dashboard_path
    else
      flash.now[:alert] = I18n.t('incorrect_username_or_password')
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
  end
end
