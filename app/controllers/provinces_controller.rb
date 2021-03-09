class ProvincesController < Pumi::ProvincesController
  skip_before_action :check_guisso_cookie
  BATTAMBANG = '02'
  KOMPONG_CHHNANG = '04'

  def index
    render(json: Pumi::ResponseSerializer.new(pilot_provinces))
  end

  private

  def pilot_provinces
    [BATTAMBANG, KOMPONG_CHHNANG].map do |id|
      Pumi::Province.find_by_id(id)
    end
  end
end
