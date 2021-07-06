module LiquidServices
  class DateLiquid
    def to_h
      date = Date.today
      { 'current_day' => date.strftime("%d"),
        'current_month' => date.strftime("%B"),
        'current_year' => date.strftime("%Y")
      }
    end
  end
end
