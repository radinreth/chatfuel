class WelcomesController < ApplicationController
  skip_before_action :authenticate_user_with_guisso!

  def index
    render layout: "welcome"
  end

  def show
    render layout: "public_dashboard"
  end
end
