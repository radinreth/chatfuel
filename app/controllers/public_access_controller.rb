class PublicAccessController < ActionController::Base
  include Pagy::Backend

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
end
