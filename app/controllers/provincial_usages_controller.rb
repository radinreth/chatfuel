class ProvincialUsagesController < ApplicationController
  include Filterable

  before_action :default_start_date
  before_action :set_daterange
  before_action :set_query

  def index
    @pagy, @provincial_usages = pagy_array(ProvincialUsage.within(@query))
  end

  private

  def set_query
    @query ||= DashboardQuery.new(filter_options)
  end

  def default_start_date
    Setting.dashboard_start_date.strftime('%Y/%m/%d')
  end
end
