class DistrictsController < Pumi::DistrictsController
  skip_before_action :check_guisso_cookie

  def index
    render(json: Pumi::ResponseSerializer.new(filter_districts))
  end

  private

  def filter_districts
    real_district_codes.map { |id| Pumi::District.find_by_id(id) }
  end

  def real_district_codes
    other_district_code = "0000"

    all_district_codes - [other_district_code]
  end

  def all_district_codes
    loc_var = Variable.location

    return [] if loc_var.nil?

    loc_var.values.map(&:raw_value)
  end
end
