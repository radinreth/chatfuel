class AccessInfo < Report
  def result
    @result = raw_result
    self
  end

  def transform
    {
      colors: generate_colors,
      dataset: dataset
    }
  end

  private
    def generate_colors
      return [] unless @result

      super.take(@result.count)
    end

    def dataset
      return {} unless @result

      @result
    end

    def raw_result
      Message.unscope(:order).accessed(@query.options).\
        group_by_month(:created_at, format: "%b").count
    end
end
