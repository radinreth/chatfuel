require "csv"
require_relative "time_parser"

class SiteService
  def initialize(options = {})
    @options = options
  end

  def self.import(path)
    ::CSV.foreach(path, headers: true, encoding: "bom|utf-8") do |row|
      hash = row.to_hash
      TimeParser.parse(hash) do |parsed|
        site = ::Site.new(parsed)
        site.save
      end
    end
  end

  def provinces
    site_provinces.as_json.each do |province|
      province['sites_count'] = site_count_in_province[province['id']]
      province['sites'] = get_sites_in_province(province['id'])
    end
  end

  private
    def site_provinces
      @site_provinces ||= Pumi::Province.all.select{ |province| site_count_in_province.keys.include? province.id }
    end

    def site_count_in_province
      @site_count_in_province ||= Site.filter(@options).group(:province_id).count
    end

    def get_sites_in_province(province_id)
      sites_in_provinces.select { |site| site.province_id == province_id }
    end

    def sites_in_provinces
      @sites_in_province ||= Site.filter(@options).where(province_id: site_count_in_province.keys).includes(:sync_logs)
    end
end
