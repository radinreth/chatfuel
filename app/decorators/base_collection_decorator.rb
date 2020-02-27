class BaseCollectionDecorator
  attr_reader :period

  def initialize(sym, period)
    @sym = sym
    @period = period
  end

  def name
    @sym.to_s.titleize
  end

  def data
    collection.group_by_period(period.name, :created_at, range: period.date_range).count
  end
end
