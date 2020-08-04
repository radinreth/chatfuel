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

      def response_template(ticket)
        type = "#{ticket.platform_name}Template"
        @response_template ||= Template.find_by(type: type, status: ticket.progress_status)
      rescue
        Rails.logger.warn "Template for: #{ticket.platform_name} doesn't exist"
      end
  end
end
