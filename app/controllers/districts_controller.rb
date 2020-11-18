class DistrictsController < Pumi::DistrictsController
  def index
    render(json: Pumi::ResponseSerializer.new(filter_districts))
  end

  private

  def filter_districts
    ["0204", "0212"].map { |id| Pumi::District.find_by_id(id) }
  end
end
