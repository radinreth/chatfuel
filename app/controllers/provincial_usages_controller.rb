class ProvincialUsagesController < ApplicationController
  respond_to :html, :csv
  include Filterable

  before_action :default_start_date
  before_action :set_daterange
  before_action :set_query
  before_action :set_gon

  def index
    @pagy, @provincial_usages = pagy_array(@query.provincial_usages)
    respond_with(@provincial_usages)
  end

  private

  def set_query
    @query ||= DashboardQuery.new(filter_options)
  end

  def default_start_date
    Setting.dashboard_start_date.strftime('%Y/%m/%d')
  end

  def set_gon
    gon.push({
      locale: I18n.locale,
      start_date: @start_date,
      end_date: @end_date
    })
  end
end
