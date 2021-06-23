class ProvincialUsagesController < ApplicationController
  include Filterable

  before_action :default_start_date
  before_action :set_daterange

  def index
    @pagy, @provincial_usages = pagy_array(ProvincialUsage.all)
  end

  private

  def default_start_date
    Setting.dashboard_start_date.strftime('%Y/%m/%d')
  end
end
