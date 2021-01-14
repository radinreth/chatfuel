module WelcomeHelper
  def t_name
    "full_name_#{I18n.locale}".to_sym
  end

  def district(district_id)
    Pumi::District.find_by_id(district_id)
  end
end