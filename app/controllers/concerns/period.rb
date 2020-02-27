# OPTIMIZE: move applicationjs sprocket to webpacker ( issue on daterangepicker)
class Period
  attr_reader :start_date, :end_date

  def initialize(dates)
    start_date, end_date = (dates || "#{Time.now} - #{Time.now}") .split(' - ')
    @start_date = Time.parse(start_date)
    @end_date = Time.parse(end_date)
  end

  def name
    case
    when duration_in_day <= 1 then :hour
    when duration_in_day <= 7 then :day
    when duration_in_day <= 180 then :week
    when duration_in_day <= 365 then :month
    else :quarter
    end
  end

  def duration_in_day
    (end_date - start_date) / 1.day
  end

  def date_range
    [start_date, end_date]
  end
end