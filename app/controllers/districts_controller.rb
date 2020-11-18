class DistrictsController < Pumi::DistrictsController
  def index
    render(json: Pumi::ResponseSerializer.new(filter_districts))
  end

  private

  def filter_districts
    exact_district_codes.map { |id| Pumi::District.find_by_id(id) }
  end

  def exact_district_codes
    district_codes.delete_if { |code| code == "0000" }
  end

  def district_codes
    # return [] unless Variable.location.present?

    Variable.location.values.map(&:raw_value)
  end
end
