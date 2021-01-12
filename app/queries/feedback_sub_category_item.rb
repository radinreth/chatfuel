class FeedbackSubCategoryItem < FeedbackSubCategories
  def chart_options
    @query.district_codes_without_other.each_with_object({}) do |district_id, hash|
      hash[district_id] ||= {}
      district = ::Pumi::District.find_by_id(district_id)
      hash[district_id][:locationName] = district.send("name_#{I18n.locale}".to_sym)
      hash[district_id][:ratingLabels] = result_set_mapping[district_id].keys rescue []
      hash[district_id][:dataset] = dataset(district_id)
    end
  end

  private
    def dataset(key)
      @values = result_set_mapping[key].values rescue []

      values.map.with_index do |mapping_value, index|
        {
          label: mapping_value,
          backgroundColor: colors[index],
          data: @values.map { |raw| raw[mapping_value] || 0 }
        }
      end
    end

    def result_set_mapping
      return {} unless result_set

      result_set.each_with_object({}) do |(key, count), hash|
        variable_id, value_id, district_id = key
        variable_value = VariableValue.find(value_id)
        variable = variable_value.variable

        hash[district_id] ||= {}
        hash[district_id][I18n.t(variable.name)] ||= {}
        hash[district_id][I18n.t(variable.name)][variable_value.mapping_value] = count
      end
    end

    def result_set
      scope = sql.group("messages.district_id")
      scope.count
    end
end
