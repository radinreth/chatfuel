class WelcomesController < ApplicationController
  skip_before_action :authenticate_user_with_guisso!

  def index
    

    respond_to do |format|
      format.html { render layout: "welcome" }
      format.js do
        @query = DashboardQuery.new(filter_options)
      end
    end
  end

end
