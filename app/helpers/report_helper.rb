module ReportHelper
  def chart_data(goals)
    goals.map do |goal|
      { name: goal.name, data: goal.data }
    end
  end
end
