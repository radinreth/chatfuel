module Channels
  class EmptyChannel
    def send_message
      Rails.logger.debug "EmptyChannel: #{self}"
    end
  end
end
