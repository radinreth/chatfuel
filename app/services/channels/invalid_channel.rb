module Channels
  class InvalidChannel
    def send_message
      Rails.logger.debug "EmptyChannel: #{self}"
    end
  end
end
