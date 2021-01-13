class FeedbackSubCategories < FeedbackReport
  private
    def labels
      result_set_mapping["all"].keys
    end

    def dataset
      values.map.with_index do |mapping_value, index|
        chart_item(mapping_value, index, data_values)
      end
    end

    def data_values
      result_set_mapping["all"].values
    end

    def result_set_mapping
      mapping(result_set)
    end

    def result_set
      sql.count
    end
end
