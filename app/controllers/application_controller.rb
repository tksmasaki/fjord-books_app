# frozen_string_literal: true

class ApplicationController < ActionController::Base
  around_action :switch_locale

  def default_url_options
    # default_localeと等しい時は、ヘルパーメソッドで生成するurlにlocaleを含めない
    I18n.locale == I18n.default_locale ? { locale: nil } : { locale: I18n.locale }
  end

  private

  def switch_locale(&action)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &action)
  end
end
