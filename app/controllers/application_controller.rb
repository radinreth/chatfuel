# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # before_action :authenticate_api_user!
  # before_action :authenticate_user_with_guisso!
  skip_before_action :verify_authenticity_token
end
