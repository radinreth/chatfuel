module Channels
  class InvalidChannel
    def send_message
      Rails.logger.debug "InvalidChannel: #{self}"
    end
  end
end
