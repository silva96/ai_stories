# frozen_string_literal: true
Pagy::DEFAULT[:size] = [1, 1, 1, 1]
locales = Constants::AVAILABLE_LOCALES.map { |locale| { locale: locale.to_s } }
Pagy::I18n.load(*locales)
