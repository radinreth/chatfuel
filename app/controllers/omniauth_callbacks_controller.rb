# frozen_string_literal: true

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  class Forbidden < StandardError; end

  skip_before_action :authenticate_user_with_guisso!
  skip_before_action :verify_authenticity_token
  skip_before_action :check_guisso_cookie

  def instedd
    user = User.from_omniauth(request.env["omniauth.auth"].to_h)

    if user.actived? && user.role.present?
      sign_in user

      next_url = request.env["omniauth.origin"] || root_path
      next_url = root_path if next_url == new_user_session_path
      redirect_to next_url
    else
      raise Forbidden, "You are not allowed to access this page."
    end
  end
end
