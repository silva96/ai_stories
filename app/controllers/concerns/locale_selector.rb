# frozen_string_literal: true

module LocaleSelector
  def set_locale
    I18n.locale = infer_locale
    @pagy_locale = I18n.locale.to_s
  end

  def infer_locale
    locale = params[:hl] || request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
    return locale if Constants::AVAILABLE_LOCALES.include? locale

    I18n.default_locale
  end
end
