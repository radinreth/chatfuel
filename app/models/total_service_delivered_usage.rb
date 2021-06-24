class TotalServiceDeliveredUsage
  def self.fetch(options)
    @options = options
    StepValue.filter(delivered_options, delivered_scope)\
              .group(:province_id)\
              .count
  end

  private

  def self.delivered_options
    @options.merge({ variable_id: Variable.user_visit&.id })
  end

  def self.delivered_scope
    StepValue.joins(:session, variable_value: :variable)
  end
end
