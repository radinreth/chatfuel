module Channel
  class EmptyChannel
    def send
      Rails.logger.debug "EmptyChannel: #{self}"
    end
  end
end
