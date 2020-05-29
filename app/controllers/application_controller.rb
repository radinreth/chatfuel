# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include Pagy::Backend
  include Pundit

  before_action :authenticate_user_with_guisso!
  before_action :set_raven_context
  around_action :switch_locale

  def default_url_options
    { locale: I18n.locale }
  end

  private
    def user_not_authorized
      flash[:alert] = t("not_authorized")
      redirect_to(reports_path) && return
    end

    def switch_locale(&action)
      locale = params[:locale] || I18n.default_locale
      I18n.with_locale(locale, &action)
    end

    def set_raven_context
      Raven.user_context(id: session[:current_user_id])
      Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    end
end
