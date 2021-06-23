# query options (filter)
# province filter
class ProvincialUsage
  attr_reader :pro_code, :unique_user, :visit, :service_delivered
  # pivot by province
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
    {"08"=>63, "12"=>377, nil=>3794, "21"=>65, "06"=>22, 
      "10"=>5, "00"=>2673, "03"=>20, "13"=>9, "17"=>113, 
      "15"=>40, "01"=>2783, "04"=>1124, "20"=>32, "14"=>31, 
      "22"=>5, "02"=>23766, "nu"=>4, "07"=>26, "18"=>5, 
      "11"=>97, "09"=>3, "05"=>33
    }
  end
end

class TotalUniqueUser
  def self.all
    {
      "00"=>297, "01"=>181, "02"=>2821, "03"=>4, 
      "04"=>94, "05"=>3, "06"=>3, "07"=>5, "08"=>9, 
      "09"=>1, "10"=>1, "11"=>12, "12"=>50, "13"=>3, 
      "14"=>6, "15"=>6, "17"=>10, "18"=>1, "20"=>4, 
      "21"=>4, "22"=>1, nil=>1114
    }
  end
end


class TotalVisit
  attr_reader :pro, :count

  def initialize(pro, count)
    @pro = pro
    @count = count
  end

  def self.all
    # query.map { |pro, count| new(pro, count) }
    {"00"=>579, "01"=>404, "02"=>5420, "03"=>4, 
      "04"=>167, "05"=>5, "06"=>4, "07"=>5, 
      "08"=>12, "09"=>1, "10"=>1, "11"=>19, 
      "12"=>66, "13"=>3, "14"=>6, "15"=>8, "17"=>18, 
      "18"=>1, "20"=>5, "21"=>10, "22"=>1, nil=>1306
    }
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
