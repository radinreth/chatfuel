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

  def generate_colors
    %w(#E25241 #75038E #12A6A6 #C79553 #ffce56
       #07F572 #F47E3D #DFC5F1 #4127B1 #E87CB9
       #B953F6 #1D203F #BD2F28 #0448FD #2F3559 )
  end
end
