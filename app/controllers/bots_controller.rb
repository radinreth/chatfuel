class BotsController < ApplicationController
  skip_before_action :authenticate_user_without_guisso!
  skip_before_action :verify_authenticity_token
end
