module LiquidServices
  class BaseLiquid
    def to_h
      { 
        'site' => site.to_h,
        'chart' => chart.to_h
      }
    end

    private

    def site
      @site ||= SiteLiquid.new
    end

    def chart
      @chart ||= ChartLiquid.new
    end
  end
end
