class MarkAsValidator
  def initialize(variable)
    @variable = variable
  end

  def validate
    return if mark_as.blank?

    @variable.errors.add(mark_as, I18n.t("variable.already_taken")) if Variable.exists?(mark_as: mark_as)
  end

  private
    def mark_as
      @variable.mark_as
    end
end
