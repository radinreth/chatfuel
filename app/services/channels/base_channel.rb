module Channels
  class BaseChannel
    def self.get(platform)
      "Channels::#{platform}Channel".constantize.new
    rescue
      Rails.logger.warn "#{platform} doesn't exist"
      Channels::InvalidChannel.new
    end

    def send_message(ticket); raise "you have to implement in subclass" end

    private
      def text_message(template)
        liquid_template = Tilt::LiquidTemplate.new { template.content }
        liquid_template.render
      end

      def response_template(status, platform_name)
        @response_template ||= Template.for(status, platform_name)
      end
  end
end
