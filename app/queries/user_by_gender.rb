class UserByGender < Report
  def result
    @result = @query.users_visited_by_each_genders
    self
  end

  def transform
    {
      colors: Feedback::COLORS.reverse,
      dataset: @result
    }
  end
end
