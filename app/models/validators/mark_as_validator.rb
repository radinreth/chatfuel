class MarkAsValidator
  def initialize(variable)
    @variable = variable
  end

  def validate
    return if mark_as.blank?

    mark_as_variable = Variable.send(mark_as.to_sym)
    @variable.errors.add(mark_as, I18n.t("variable.already_taken")) if mark_as_variable.present? && mark_as_variable != @variable
  rescue
    @variable.errors.add(:mark_as, I18n.t("variable.invalid_mark_as"))
  end

  private
    def mark_as
      @variable.mark_as
    end
end
