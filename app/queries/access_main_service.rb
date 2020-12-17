class AccessMainService < Report
  def result
    @result = raw_result
    self
  end

  def transform
    {
      colors: colors.first,
      dataset: dataset
    }
  end

  private

    def dataset
      return {} unless @result

      @result.transform_keys do |value_id|
        value = VariableValue.find(value_id)
        value.mapping_value
      end
    end

    def raw_result
      scope = StepValue.filter(@variable.step_values, @query.options)
      scope = scope.group("variable_value_id")
      scope.count
    end
end
