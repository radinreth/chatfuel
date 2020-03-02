require 'csv'
require_relative 'time_parser'

module Seed
  class Ticket
    def self.generate!
      CSV.foreach('db/seed/assets/tickets.csv', headers: true) do |row|
        hash = row.to_hash

        TimeParser.parse(hash) do |parsed|
          ticket = ::Ticket.new(parsed)
          ticket.save
        end
      end
    end
  end
end
