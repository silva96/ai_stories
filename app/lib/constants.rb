# frozen_string_literal: true

module Constants
  AVAILABLE_LOCALES = %w[es en].freeze
  FATHOM_SITE_ID = ENV.fetch('FATHOM_SITE_ID', nil)
end
