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
    hash = StepValue.total_users_feedback(@query.options)
    hash.transform_keys { |k| "#{icon_map[k]} #{k}" }
  end

  def icon_map
    status_to_icon.each_with_object({}) { |(k,v), h| h[I18n.t(k)] = v }
  end

  def status_to_icon
    { like: "😍", acceptable: "😊", dislike: "😞" }
  end
end
