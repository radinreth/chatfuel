class LocationsController < ApplicationController
  include Filterable
  
  def show
    render json: { display_name: @location_filter.display_name, described_name: @location_filter.described_name }
  end
end
