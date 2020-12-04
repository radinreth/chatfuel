class MostRequest < Report
  def result
    @result = group_count
    self
  end

  def transform
    {
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

  def dataset
    @result.each_with_object({}) do |(key, count), hash|
      district, variable_value = find_objects_by(key)
      hash_key = district.send("name_#{I18n.locale}".to_sym)

      hash[hash_key] = {
        value: replace_new_line(variable_value.mapping_value),
        count: count
      } if !hash[hash_key] || hash[hash_key][:count] < count
    end
  end

  def replace_new_line(str)
    str.sub(/\s/, "\n")
  end

  def group_count
    scope = @variable.step_values.joins(:message)
    scope = scope.where.not(messages: { district_id: ["", "null"] })
    scope = scope.where(messages: { district_id: @query.options[:district_id] }) if @query.options[:district_id].present?
    scope = scope.group("messages.district_id")
    scope = scope.group(:variable_value_id)
    scope = scope.count
    scope
  end
end
