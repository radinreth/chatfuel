class DashboardController < ApplicationController
  before_action :set_daterange

  def show
    @query = DashboardQuery.new(filter_options)
  end
end
