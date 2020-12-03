class MostTrackedPeriodic < Report
  def result
    @result = group_count
    self
  end

  def transform
    {
      max: max,
      label: I18n.t("welcomes.most_requested_services"),
      colors: generate_colors,
      dataset: dataset
    }
  end

  private

  def generate_colors
    return [] unless @result

    super.take(@result.count)
  end

  def max
    @result.values.max
  end

  def dataset
    @result.each_with_object({}) do |(key, count), hash|
      month, variable_value = find_objects_by(key)
      hash[month] = {
        value: replace_new_line(variable_value.mapping_value),
        count: count
      } if !hash[month] || hash[month][:count] < count
    end
  end

  def replace_new_line(str)
    str.sub(/\s/, "\n")
  end

  def find_objects_by(key)
    month, variable_value_id = key
    variable_value = VariableValue.find(variable_value_id)

    [month, variable_value]
  end

  def group_count
    @variable.step_values.joins(:message)\
      .where.not(messages: { district_id: ["", "null"] })\
      .group_by_month("messages.created_at", format: "%b")\
      .group(:variable_value_id)\
      .count
  end
end
