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
      period = @query.options[:period].presence || :month

      Message.unscope(:order).accessed(@query.options).\
        group_by_period(period.to_sym, :created_at, format: "%d/%b").count
    end
end
