class NotifiedStatus
  def initialize(decorator)
    @decorator = decorator
  end

  def status
    I18n.t(".status", scope: i18n_scope)
  end

  def description
    I18n.t(".description", scope: i18n_scope)
  end

  private
    def i18n_scope
      [:decorators, :concerns, :notified_status]
    end
end