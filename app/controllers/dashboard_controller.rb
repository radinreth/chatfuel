class DashboardController < ApplicationController
  include Filterable

  before_action :default_start_date
  before_action :set_daterange
  before_action :set_gon

  def show
    @criteria = VariableValue.criteria
    @variables = Variable.includes(:values).all
    @query = DashboardQuery.new(filter_options)
  end

  private

  def default_start_date
    Setting.dashboard_start_date.strftime('%Y/%m/%d')
  end

  def set_gon
    @query = DashboardQuery.new(filter_options)
    gon_data = Gonify.new(@query).chart_data
    gon_data[:no_data] = I18n.t("no_data")
    gon.push(gon_data)
  end
end
