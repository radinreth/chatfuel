class FeedbackSubCategories < FeedbackReport
  def labels
    result_set_mapping["all"].keys
  end
  
  def dataset
    values.map.with_index do |mapping_value, index|
      dataset_item(mapping_value, index, data_values)
    end
  end
  
  private
    def data_values
      result_set_mapping["all"].values
    end

    def result_set_mapping
      accumulate_rating_each_variable(result_set)
    end

    def result_set
      sql.count
    end
end
