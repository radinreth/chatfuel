class WelcomeController < ApplicationController
  layout 'welcome'
  skip_before_action :authenticate_user_with_guisso!

  def index
  end
end
