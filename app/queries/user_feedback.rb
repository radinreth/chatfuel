class UserFeedback < Report
  def result
    @result = raw
    self
  end

  def transform
    {
      colors: Feedback::COLORS.reverse,
      dataset: @result
    }
  end

  private

  def raw
    StepValue.total_users_feedback(@query.options)
  end
end
