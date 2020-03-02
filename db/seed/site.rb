require 'csv'
require_relative 'time_parser'

module Seed
  class Site
    def self.generate!(path = 'db/seed/assets/site.csv')
      p 'Create sites'
      CSV.foreach(path, headers: true) do |row|
        hash = row.to_hash
        TimeParser.parse(hash) do |parsed|
          site = ::Site.new(parsed)
          site.save
        end
      end
    end
  end
end