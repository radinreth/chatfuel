class WelcomesController < ApplicationController
  skip_before_action :authenticate_user_with_guisso!
  before_action :set_daterange

  def index
    respond_to do |format|
      format.html { render layout: "welcome" }
      format.js do
        @query = DashboardQuery.new(filter_options)
      end
    end
  end

  private
    def default_start_date
      Setting.dashboard_start_date.strftime('%Y/%m/%d')
    end
end
