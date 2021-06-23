# query options (filter)
# province filter
class ProvincialUsage
  attr_reader :pro_code, :unique_user, :visit, :service_delivered

  def initialize(pro_code:, unique_user:, visit:, service_delivered:)
    @pro_code = pro_code
    @unique_user = unique_user
    @visit = visit
    @service_delivered = service_delivered
  end

  def self.all
    ProvinceFilter.fetch(pro_codes).map do |pro_code|
      new(
        pro_code: pro_code,
        unique_user: unique_users[pro_code],
        visit: visit[pro_code],
        service_delivered: service_delivered[pro_code]
      )
    end
  end

  def self.unique_users
    @unique_users ||= TotalUniqueUser.all
  end

  def self.visit
    @visit ||= TotalVisit.all
  end

  def self.service_delivered
    @service_delivered ||= ServiceDelivered.all
  end

  def self.pro_codes
    Filters::PumiFilter.pilot_province_codes
  end
end

class ServiceDelivered
  def self.all
    scope = StepValue.joins(:session, variable_value: :variable)
    StepValue.filter({ start_date: "2020/08/28",
                        end_date: "2021/06/21", 
                        variable_id: Variable.user_visit.id }, 
                        scope)\
              .group(:province_id)\
              .count
  end
end

class TotalUniqueUser
  def self.all
    unique_sql = Session.filter(start_date: "2020/08/28", end_date: "2021/06/21")\
            .select("DISTINCT ON (session_id) *")\
            .reorder(:session_id, :gender)\
            .to_sql

    Session.select("*").from("(#{unique_sql}) sessions")\
            .unscope(:order)\
            .group(:province_id)\
            .count
  end
end


class TotalVisit
  def self.all
    query
  end

  private

  def self.query
    Session\
      .filter(start_date: "2020/08/28", \
              end_date: "2021/06/21")  \
      .unscope(:order)\
      .group(:province_id)\
      .count
  end
end
