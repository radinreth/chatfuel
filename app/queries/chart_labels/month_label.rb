module ChartLabels
  class MonthLabel
    def initialize(raw)
      @raw = raw
    end

    def format
      @raw.split(",")[0]
    end
  end
end