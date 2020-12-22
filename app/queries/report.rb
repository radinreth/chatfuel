class Report
  def initialize(variable, query = nil)
    @variable = variable
    @query = query
  end

  private

  def find_objects_by(key)
    district_id, variable_value_id = key

    district = Pumi::District.find_by_id(district_id)
    variable_value = VariableValue.find(variable_value_id)

    [district, variable_value]
  end

  def colors
    Color.generate(@result&.count.to_i)
  end

  def period
    (@query.options[:period].presence || 'month').to_sym
  end

  def format_label(k)
    return k if period != :quarter

    m, y = k.split("/")
    q = Quarterly.new(m)
    I18n.t("chart.quarter_label", q: q.to_quarter, y: y)
  end
end
