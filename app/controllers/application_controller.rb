# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit

  before_action :authenticate_user_with_guisso!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
    def user_not_authorized
      flash[:alert] = "You are not authorized"
      redirect_to(request.referrer || reports_path) && return
    end
end
