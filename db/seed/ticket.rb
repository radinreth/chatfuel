require "csv"
require "time_parser"

module Seed
  class Ticket
    def self.generate!
      side_ids = ::Site.ids
      CSV.foreach("db/seed/assets/tickets.csv", headers: true) do |row|
        hash = row.to_hash

        TimeParser.parse(hash) do |parsed|
          ticket = ::Ticket.new(parsed)
          ticket.created_at = (2..10).to_a.sample.days.ago
          ticket.site_id = side_ids.sample
          ticket.save
        end
      end
    end
  end
end
