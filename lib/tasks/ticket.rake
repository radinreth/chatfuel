require 'csv'
require_relative 'time_parser'

namespace :ticket do
  desc 'source tickets to database'
  task :source => :environment do
    Ticket.destroy_all

    CSV.foreach('lib/tasks/tickets.csv', headers: true) do |row|
      hash = row.to_hash

      TimeParser.parse(hash) do |parsed|
        ticket = Ticket.new(parsed)
        ticket.save
      end
    end
  end
end

