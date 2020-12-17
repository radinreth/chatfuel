class DistrictsController < Pumi::DistrictsController
  include Filterable
  skip_before_action :check_guisso_cookie

  def index
    render(json: Pumi::ResponseSerializer.new(filter_districts))
  end

  private
    def filter_districts
      query = DashboardQuery.new(filter_options)

      query.district_codes_without_other.map { |id| Pumi::District.find_by_id(id) }
    end
end
