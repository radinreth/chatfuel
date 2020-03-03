# TODO: add spec

class BaseCollectionDecorator
  include ActionView::Helpers
  attr_reader :period, :sym

  def initialize(sym, period)
    @sym = sym
    @period = period
  end

  def name
    @sym.to_s.titleize
  end

  def total
    collection.count
  end

  def average
    number_to_percentage(total / period.duration_in_day, precision: 1)
  end

  def data
    collection.group_by_period(period.name, :created_at, range: period.date_range).count
  end
end
