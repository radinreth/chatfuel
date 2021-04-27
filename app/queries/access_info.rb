class AccessInfo < BasicReport
  def dataset
    result_set.transform_keys { |k| format_label(k) }
  end

  private
    def result_set
      scope = Session.unscope(:order)
      scope = scope.accessed(@query.options)
      scope = scope.group_by_period(period, :created_at, format: "%b/%y,%Y")
      scope.count
    rescue
      {}
    end
end