class TotalMostRequestServiceUsage
  LAST_ITEM_IN_ARRAY = -1

  def self.fetch(options)
    @options = options
    query.each_with_object({}).each do |(key, count), cloned|
      pro_code, variable_value_id = key
      cloned[pro_code] = [variable_value_name(variable_value_id), count, 0] unless cloned[pro_code]
      cloned[pro_code][LAST_ITEM_IN_ARRAY] += count
    end
  end

  private

  def self.variable_value_name(id)
    VariableValue.find(id).mapping_value
  end

  def self.query
    StepValue.filter(@options.merge(variable_options))\
              .joins(:session)\
              .group(:province_id, :variable_value_id)\
              .order(:province_id, count_all: :desc)\
              .count
  end

  def self.variable_options
    { variable_id: Variable.most_request&.id }
  end
end
