class ProvincialUsagesController < ApplicationController
  include Filterable

  before_action :default_start_date
  before_action :set_daterange
  before_action :set_query
  before_action :set_gon

  def index
    @provincial_usages = ProvincialUsageDecorator.decorate_collection(@query.provincial_usages)
    respond_to do |format|
      format.html
      format.csv {
        response.headers['Content-Disposition'] = "attachment; filename=\"#{csv_file_name}\""
        render csv: @provincial_usages
      }
    end
  end

  private

  def csv_file_name
    "provincial_usages-#{DateTime.current.strftime("%Y%m%d%H%M%S")}.csv"
  end

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
