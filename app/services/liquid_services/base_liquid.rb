module LiquidServices
  class BaseLiquid
    def initialize(site)
      @site = site
    end

    def to_h
      { 
        'site' => site_locals.to_h,
        'chart' => chart_locals.to_h,
        'date' => date_locals.to_h,
      }
    end

    private

    def site_locals
      @site_locals ||= SiteLiquid.new(@site)
    end

    def date_locals
      @date_locals ||= DateLiquid.new
    end

    def chart_locals
      @chart_locals ||= ChartLiquid.new
    end
  end
end
