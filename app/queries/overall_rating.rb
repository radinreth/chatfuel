class OverallRating < Feedback
  def chart_options
    mapping.each_with_object({}) do |(pro, districts), hash|
      hash[pro] ||= {}
      hash[pro][:labels] = districts.keys
      hash[pro][:dataset] = display_values.map do |values|
            id, raw_value, mapping_value = values
            {
              label: mapping_value,
              backgroundColor: colors_mapping[raw_value],
              data: districts.values.map { |raw| raw[mapping_value] || 0 }
            }
          end
    end
  end

  private
    
    def mapping
      result_set.each_with_object({}) do |(key, count), hash|
        pro, dis, var = find_objects_by(key)
        location = dis.send("name_#{I18n.locale}".to_sym)
      
        hash[pro] ||= {}
        hash[pro][location] ||= {}
        hash[pro][location][var.mapping_value] ||= count
      end
    end

    def find_objects_by(key)
      pro_code = key.shift
      [pro_code] + super(key)
    end

    def result_set
      scope = StepValue.filter(@query.options, @variable.step_values)
      scope = scope.joins(:session)
      scope = scope.where(sessions: { district_id: @query.district_codes_without_other })
      scope = scope.group("sessions.province_id")
      scope = scope.group("sessions.district_id")
      scope = scope.group(:variable_value_id)
      scope.count
    end
end