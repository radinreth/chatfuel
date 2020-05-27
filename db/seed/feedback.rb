require "csv"
require "time_parser"

module Seed
  class Feedback
    def self.generate!
      CSV.foreach('db/seed/assets/feedback.csv', headers: true) do |row|
        hash = row.to_hash

        step_ids = ::Step.ids
        TimeParser.parse(hash) do |parsed|
          feedback = ::Feedback.new(parsed)
          feedback.step_id = step_ids.sample
          feedback.save
        end
      end
    end
  end
end
