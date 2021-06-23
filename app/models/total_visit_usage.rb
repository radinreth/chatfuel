class TotalVisitUsage
  def self.fetch(options)
    Session.filter(options)\
            .unscope(:order)\
            .group(:province_id)\
            .count
  end
end
