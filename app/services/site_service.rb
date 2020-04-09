require "csv"
require_relative "time_parser"

class SiteService
  def self.import(path)
    ::CSV.foreach(path, headers: true, encoding: "bom|utf-8") do |row|
      hash = row.to_hash
      TimeParser.parse(hash) do |parsed|
        site = ::Site.new(parsed)
        site.save
      end
    end
  end
end
