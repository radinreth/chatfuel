module LiquidServices
  class SiteLiquid
    def initialize(site)
      @site = site
    end

    def to_h
      { 'name' => @site.name_i18n,
        'province_name' => @site.pumi_province&.send("name_#{I18n.locale}".to_sym) }
    end
  end
end
