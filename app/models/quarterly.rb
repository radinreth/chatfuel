class Quarterly
  # transform valid month into quarter
  def initialize(month)
    @month = month
  end

  def to_quarter
    (month_index / 3.0).ceil
  end

  private
    def month_index
      I18n.t(:abbr_month_names, scope: :date).index(@month) || raise("#{@month} is not a valid month")
    end
end
