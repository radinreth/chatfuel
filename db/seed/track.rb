require "csv"
require "time_parser"

module Seed
  class Track
    def self.generate!
      CSV.foreach("db/seed/assets/tracks.csv", headers: true) do |row|
        hash = row.to_hash

        site_ids = ::Site.ids
        step_ids = ::Step.ids
        ticket_ids = ::Ticket.ids

        TimeParser.parse(hash) do |parsed|
          track = ::Track.new(parsed)

          ticket_id = ticket_ids.sample

          track.site_id = site_ids.sample
          track.step_id = step_ids.sample
          track.ticket_id = ticket_id
          ticket_ids.delete(ticket_id)

          track.save
        end
      end
    end
  end
end
