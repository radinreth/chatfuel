require 'csv'
require_relative 'time_parser'

module Seed
  class Site
    def self.generate!
      ::Site.destroy_all

      p 'Create sites'
      CSV.foreach('db/seed/assets/site.csv', headers: true) do |row|
        hash = row.to_hash
        TimeParser.parse(hash) do |parsed|
          site = ::Site.new(parsed)
          site.save
        end
      end
    end
  end
end