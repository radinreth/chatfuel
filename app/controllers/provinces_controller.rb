class ProvincesController < Pumi::ProvincesController
  skip_before_action :check_guisso_cookie

  def index
    render(json: Pumi::ResponseSerializer.new(filter_provinces))
  end

  private

  def filter_provinces
    Pumi::Province.where(id: "02")
  end
end
