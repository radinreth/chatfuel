require "csv"
require "time_parser"

module Seed
  class Ticket
    def self.generate!
      CSV.foreach("db/seed/assets/tickets.csv", headers: true) do |row|
        hash = row.to_hash

        TimeParser.parse(hash) do |parsed|
          ticket = ::Ticket.new(parsed)
          ticket.created_at = (2..10).to_a.sample.days.ago
          ticket.site = ::Site.find_by(code: parsed["code"][0...4])
          ticket.save
        end
      end
    end
  end
end
