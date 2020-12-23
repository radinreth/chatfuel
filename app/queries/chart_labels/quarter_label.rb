module ChartLabels
  class QuarterLabel
    def initialize(raw)
      @m, @y = raw.split("/")
    end

    def format
      q = Quarterly.new(@m)
      I18n.t("chart.quarter_label", q: q.to_quarter, y: @y)
    end
  end
end
