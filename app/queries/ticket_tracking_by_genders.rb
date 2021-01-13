class TicketTrackingByGenders < BasicReport
  private
    def dataset
      result_set.transform_keys do |raw|
        gender = @query.mapping_variable_value[raw]
        gender.mapping_value if gender.present?
      end
    end

    def result_set
      scope = Message.filter(@query.options).unscope(:order)
      scope = scope.where.not(gender: ["", "null"])
      scope = scope.joins(:trackings)
      scope = scope.group(:gender)
      scope.count
    end
end
