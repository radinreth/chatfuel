class DistrictsController < Pumi::DistrictsController
  include Filterable
  skip_before_action :check_guisso_cookie

  def index
    render(json: Pumi::ResponseSerializer.new(filter_districts))
  end

  private
    def filter_districts
      query = DashboardQuery.new(filter_options)

      (district_codes & query.district_codes_without_other).map do |id|
        Pumi::District.find_by_id(id)
      end
    end

    def district_codes
      Pumi::District.where(province_id: params[:province_id]).map(&:id)
    end
end
