class TicketTrackingByGenders < BasicReport
  def dataset
    result_set.transform_keys do |raw|
      gender = @query.mapping_variable_value[raw]
      gender.mapping_value if gender.present?
    end
  end

  def colors
    Gender::COLORS
  end
  
  private
    def result_set
      scope = Session.filter(@query.options).unscope(:order)
      scope = scope.where.not(gender: ["", "null"])
      scope = scope.joins(:trackings)
      scope = scope.group(:gender)
      scope.count
    end
end
