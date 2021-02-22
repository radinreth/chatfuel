class UserFeedbackGender < Report
  def dataset
    variable_value = VariableValue.type_of_user_feedback
    StepValue.total_users_feedback_by_gender(variable_value, @query.options)
  end

  def colors
    Feedback::COLORS.reverse
  end
end
