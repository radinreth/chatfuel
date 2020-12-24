module ChartLabels
  class YearLabel
    def initialize raw
      @raw = raw
    end

    def format
      @raw.split("/")[1]
    end
  end
end
