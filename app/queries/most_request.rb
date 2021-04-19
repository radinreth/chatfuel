class MostRequest < BasicReport
  def chart_options
    result_set.each_with_object({}) do |(key, count), hash|
      pro_code, district, variable_value = find_objects_by(key)
      district_name = district.send("name_#{I18n.locale}".to_sym)
      setup_default(hash, pro_code)

      colors = hash[pro_code][:colors]
      dataset = hash[pro_code][:dataset]
      district = dataset[district_name]

      if district.nil? || district[:count] < count
        colors.pop if district && district[:count] < count
        colors.push mapping_colors[variable_value.mapping_value]
        dataset[district_name] = district_dataset(variable_value, count)
      end
    end
  end

  private

  def setup_default(hash, pro_code)
    hash[pro_code] ||= {}
    hash[pro_code][:colors]  ||= []
    hash[pro_code][:dataset] ||= {}
  end

  def district_dataset(value, count)
    { value: replace_new_line(value.mapping_value), count: count }
  end

  def mapping_colors
    @variable.values.map do|v|
      v.mapping_value
    end.zip(Color.generate).to_h
  end

  def find_objects_by(k)
    pro_code = k.shift
    [pro_code] + super(k)
  end

  def replace_new_line(str)
    str.sub(/\s/, "\n")
  end

  def result_set
    scope = StepValue.filter(@query.options, @variable.step_values)
    scope = scope.joins(:session)
    scope = scope.where(sessions: { province_id: @query.province_codes })
    scope = scope.group("sessions.province_id")
    scope = scope.group("sessions.district_id")
    scope = scope.group(:variable_value_id)
    scope = scope.count
    scope
  end
end