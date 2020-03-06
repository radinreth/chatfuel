# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include Pagy::Backend
  include Pundit

  before_action :authenticate_user_without_guisso!

  private
    def user_not_authorized
      flash[:alert] = "You are not authorized"
      redirect_to(reports_path) && return
    end
end
