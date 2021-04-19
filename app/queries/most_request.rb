class MostRequest < BasicReport
  def chart_options
    result_set.each_with_object({}) do |(key, count), hash|
      pro_code, district, variable_value = find_objects_by(key)
      district_name = district.send("name_#{I18n.locale}".to_sym)
    
      hash[pro_code] ||= {}
      hash[pro_code][:colors] ||= []
      hash[pro_code][:dataset] ||= {}

      if hash[pro_code][:dataset][district_name].nil? || hash[pro_code][:dataset][district_name][:count] < count

        if hash[pro_code][:dataset][district_name].present? &&
            hash[pro_code][:dataset][district_name][:count] < count
          hash[pro_code][:colors].pop
        end

        hash[pro_code][:colors] << colors[variable_value.mapping_value]
        hash[pro_code][:dataset][district_name] = {
          value: replace_new_line(variable_value.mapping_value),
          count: count
        }
      end
    end
  end

  private

  def colors
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