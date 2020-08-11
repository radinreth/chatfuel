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

  private
    def set_daterange
      default_date = "#{7.days.ago.strftime('%Y/%m/%d')} - #{Date.current.strftime('%Y/%m/%d')}"
      @date_range = params['daterange'] || default_date
      @start_date, @end_date = @date_range.split('-')
    end
end
