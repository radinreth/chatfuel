module WelcomeHelper
  def t_name
    "full_name_#{I18n.locale}".to_sym
  end

  def district(district_id)
    Pumi::District.find_by_id(district_id)
  end

  def show_location_detail
    full_district_list_name ? @location_filter.display_name : I18n.t("dashboard.all_district")
  end

  def full_district_list_name
    @location_filter.full_district_list_name.presence
  end
end