module ChartLabels
  class BaseLabel
    def initialize(period, raw)
      @period = period
      @raw = raw
    end

    def instance
      klazz = "chart_labels/#{@period}_label".classify.constantize
      klazz.new(@raw)
    end

    def format
      raise "Must implement in sub-class"
    end
  end
end
