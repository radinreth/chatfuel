class TicketTrackingByGenders < Report
  def result
    @result = group_count
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
      ["#469BA2", "#C2E792", "#D77256"]
    end

    def dataset
      return {} unless @result

      @result.transform_keys do |raw|
        gender = @query.mapping_variable_value[raw]
        gender.mapping_value
      end
    end

    def group_count
      Message.filter(@query.options).unscope(:order)\
        .where.not(gender: ["", "null"])\
        .joins(:trackings)\
        .group(:gender)\
        .count
    end
end
