class WelcomesController < PublicAccessController
  include Filterable

  before_action :set_daterange

  def index
    @query = DashboardQuery.new(filter_options)

    respond_to do |format|
      format.html { render layout: "welcome" }
      format.js
    end
  end

  private
    def default_start_date
      Setting.dashboard_start_date.strftime('%Y/%m/%d')
    end
end
