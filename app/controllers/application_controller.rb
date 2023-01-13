# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include LocaleSelector
  before_action :set_locale
end
