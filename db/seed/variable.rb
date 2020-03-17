require "csv"
require "time_parser"

module Seed
  class Variable
    def self.generate!
      CSV.foreach("db/seed/assets/voice_variables.csv", headers: true, encoding: "bom|utf-8") do |row|
        hash = row.to_hash

        TimeParser.parse(hash) do |parsed|
          variable = ::VoiceVariable.new(parsed)

          variable.save
        end
      end
    end
  end
end
