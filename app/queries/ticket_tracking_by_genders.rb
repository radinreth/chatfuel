class TicketTrackingByGenders < Report
  def result
    @result = group_count
    self
  end

  def transform
    {
      colors: colors,
      dataset: dataset
    }
  end

  def colors
    Gender::COLORS
  end

  private
    def dataset
      return {} unless @result

      @result.transform_keys do |raw|
        gender = @query.mapping_variable_value[raw]
        gender.mapping_value if gender.present?
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
