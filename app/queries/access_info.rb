class AccessInfo < Report
  def result
    @result = raw_result
    self
  end

  def transform
    {
      colors: colors,
      dataset: dataset
    }
  end

  private
    def dataset
      return {} unless @result

      @result
    end

    def raw_result
      raw_result = Message.unscope(:order).\
                      accessed(@query.options).\
                      group_by_period(period, :created_at, format: "%b/%Y").count

      raw_result.transform_keys { |k| format_label(k) }
    end
end
