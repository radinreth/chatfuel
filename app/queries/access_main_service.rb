class AccessMainService < Report
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

      super.first
    end

    def dataset
      return {} unless @result

      @result.transform_keys do |value_id|
        value = VariableValue.find(value_id)
        value.mapping_value
      end
    end

    def raw_result
      @variable.step_values.group("variable_value_id").count
    end
end
