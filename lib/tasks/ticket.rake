require 'csv'

def parse_time(t)
  return if t.nil?

  date = Date.strptime(t, '%m/%d/%y')
  date.iso8601
end

namespace :ticket do
  desc 'source tickets to database'
  task :source => :environment do
    Ticket.destroy_all

    CSV.foreach('lib/tasks/tickets.csv', headers: true) do |row|
      hash = row.to_hash

      #TimeParser.parse(hash) do |parsed|
      #  ticket = Ticket.new(parsed)
      #  ticket.save
      #end

      hash['submitted_at'] = parse_time(hash.delete('submitted_at'))
      hash['completed_at'] = parse_time(hash.delete('completed_at'))
      hash['actual_completed_at'] = parse_time(hash.delete('actual_completed_at'))
      hash['picked_up_at'] = parse_time(hash.delete('picked_up_at'))

      ticket = Ticket.new hash
      ticket.save
    end
  end
end
