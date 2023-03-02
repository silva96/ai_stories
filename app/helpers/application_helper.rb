# frozen_string_literal: true

module ApplicationHelper
  NOTIFICATION_BACKGROUNDS = { notice: 'bg-green-50', warning: 'bg-yellow-50', alert: 'bg-red-50' }.freeze

  def notification_background(flash_type)
    NOTIFICATION_BACKGROUNDS[flash_type.to_sym] || 'bg-white'
  end
end
