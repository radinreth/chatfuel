require 'csv'
require_relative 'time_parser'

module Seed
  class Step
    def self.generate!
      ::Step.destroy_all

      p 'Create steps'
      CSV.foreach('db/seed/assets/steps.csv', headers: true) do |row|
        hash = row.to_hash

        TimeParser.parse(hash) do |parsed|
          step = ::Step.new(parsed)
          step.message_id = ::Message.ids.sample
          step.save
        end
      end
    end
  end
end
