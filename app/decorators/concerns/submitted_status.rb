class SubmittedStatus
  def initialize(decorator)
    @decorator = decorator
  end

  def status
    I18n.t(".status", scope: i18n_scope)
  end

  def description
    I18n.t(".description", datetime: @decorator.submitted_at, scope: i18n_scope)
  end

  private
    def i18n_scope
      [:decorators, :concerns, :submitted_status]
    end
end
