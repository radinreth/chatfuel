# frozen_string_literal: true

class ApplicationController < ActionController::Base

  include Pagy::Backend
  include Pundit

  before_action :set_raven_context
  before_action :switch_locale

  private
    def switch_locale
      I18n.locale = params[:locale] || I18n.default_locale
    end

    def set_raven_context
      Raven.user_context(id: session[:current_user_id])
      Raven.extra_context(params: params.to_unsafe_h, url: request.url)
    end

    def set_daterange
      @start_date = params["start_date"] || default_start_date
      @end_date = params["end_date"] || default_end_date
    end

    def default_end_date
      Date.current.strftime('%Y/%m/%d')
    end

    def default_url_options
      { locale: I18n.locale }
    end
end
