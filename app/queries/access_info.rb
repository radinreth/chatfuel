class AccessInfo < BasicReport
  private
    def dataset
      result_set.transform_keys { |k| format_label(k) }
    end

    def result_set
      scope = Message.unscope(:order)
      scope = scope.accessed(@query.options)
      scope = scope.group_by_period(period, :created_at, format: "%b/%Y")
      scope.count
    rescue
      {}
    end
end
