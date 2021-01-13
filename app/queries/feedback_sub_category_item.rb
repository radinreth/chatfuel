class FeedbackSubCategoryItem < FeedbackSubCategories
  def chart_options
    @query.district_codes_without_other.each_with_object({}) do |district_id, hash|
      hash[district_id] ||= {}
      hash[district_id][:labels] = result_set_mapping[district_id].keys rescue []
      hash[district_id][:dataset] = dataset(district_id)
    end
  end

  private
    def dataset(key)
      @values = result_set_mapping[key].values rescue []

      values.map.with_index do |mapping_value, index|
        dataset_item(mapping_value, index, @values)
      end
    end

    def result_set_mapping
      accumulate_rating_each_variable(result_set)
    end

    def result_set
      scope = sql.group("messages.district_id")
      scope.count
    end
end
