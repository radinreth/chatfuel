class Report
  def initialize(variable)
    @variable = variable
    @colors = generate_colors
  end

  private

  def generate_colors
    %w(#E25241 #60D29F #12A6A6 #C79553 #ffce56
       #07F572 #F47E3D #DFC5F1 #4127B1 #E87CB9
       #B953F6 #1D203F #BD2F28 #A3D1D8 #2F3559 )
  end
end
