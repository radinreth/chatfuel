class DashboardController < ApplicationController
  before_action :set_daterange

  def show
    @options = {
      province_id: params['province_code'],
      district_id: params['district_code'],
      start_date: @start_date,
      end_date: @end_date,
      platform: params[:platform]
    }
    @query = DashboardQuery.new(@options)
  end
end
