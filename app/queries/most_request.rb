class MostRequest < BasicReport

  def dataset
    result_set.each_with_object({}) do |(key, count), hash|
      district, variable_value = find_objects_by(key)
      hash_key = district.send("name_#{I18n.locale}".to_sym)

      hash[hash_key] = {
        value: replace_new_line(variable_value.mapping_value),
        count: count
      } if !hash[hash_key] || hash[hash_key][:count] < count
    end
  end

  private

  def replace_new_line(str)
    str.sub(/\s/, "\n")
  end

  def result_set
    scope = StepValue.filter(@query.options, @variable.step_values)
    scope = scope.joins(:message)
    scope = scope.where(messages: { district_id: @query.district_codes_without_other })
    scope = scope.group("messages.district_id")
    scope = scope.group(:variable_value_id)
    scope = scope.count
    scope
  end
end
