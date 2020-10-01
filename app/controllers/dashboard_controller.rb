class DashboardController < ApplicationController
  before_action :default_start_date
  before_action :set_daterange

  def show
    @query = DashboardQuery.new(filter_options)
  end

  private

  def default_start_date
    Setting.dashboard_start_date.strftime('%Y/%m/%d')
  end
end
