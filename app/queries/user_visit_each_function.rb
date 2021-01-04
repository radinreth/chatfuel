class UserVisitEachFunction < Report
  def result
    @result = @query.total_users_visit_each_functions
    self
  end

  def transform
    {
      colors: colors,
      dataset: @result
    }
  end
end
