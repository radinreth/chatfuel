module TemplateHelper
  def icon_name(platform_name)
    icons[platform_name]
  end

  def icons
    @icons ||= {
      "messenger"=> "facebook-square",
      "telegram" => "telegram",
      "verboice" => "phone-square"
    }
  end
end
