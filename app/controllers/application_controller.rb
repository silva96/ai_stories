# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include LocaleSelector
  before_action :set_locale
  helper_method :current_user

  def current_user
    return nil if session[:user_id].blank?

    @current_user ||= User.find(session[:user_id])
  end

  def authenticate_user
    redirect_to sign_in_path, alert: I18n.t('please_log_in') unless current_user
  end

  def login(user)
    session[:user_id] = user.id
    flash[:notice] = t('logged_in') # rubocop:disable Rails/ActionControllerFlashBeforeRender
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path, notice: I18n.t('logged_out_successfully')
  end
end
