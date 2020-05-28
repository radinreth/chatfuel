require "liquid"
require "tilt"

class NotifierService
  class << self
    def notify(completed)
      completed.find_each do |ticket|
        channel = Channel::BaseChannel.new(ticket)
        channel.send
      end
    end
  end
end
