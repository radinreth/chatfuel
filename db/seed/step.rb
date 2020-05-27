require "csv"
require "time_parser"

module Seed
  class Step
    def self.generate!
      CSV.foreach("db/seed/assets/steps.csv", headers: true) do |row|
        hash = row.to_hash

        message_ids = ::Message.ids
        TimeParser.parse(hash) do |parsed|
          step = ::Step.new(parsed)
          step.message_id = message_ids.sample
          step.save
        end
      end
    end
  end
end
