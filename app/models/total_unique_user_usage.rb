class TotalUniqueUserUsage
  def self.fetch(options)
    @options = options
    Session.select("*")\
          .from("(#{ distinct_session.to_sql }) subquery")\
          .unscope(:order)\
          .group(:province_id)\
          .count
  end

  private

  def self.distinct_session
    Session
      .filter(@options)\
      .select('DISTINCT ON (province_id, session_id) *')\
      .reorder(:province_id, :session_id, :gender)
  end
end
