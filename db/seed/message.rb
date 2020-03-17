require "csv"
require "time_parser"

module Seed
  class Message
    def self.generate!
      %w[text_message voice_message].each do |message_type|
        CSV.foreach("db/seed/assets/#{message_type}.csv", headers: true) do |row|
          hash = row.to_hash

          TimeParser.parse(hash) do |parsed|
            content = "::#{message_type.classify}".constantize.new(parsed)
            ::Message.create content: content
          end
        end
      end
    end
  end
end
