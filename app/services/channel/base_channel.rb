module Channel
  class BaseChannel
    attr_accessor :ticket

    def initialize(ticket)
      @ticket = ticket
    end

    def send
      return false if ENV["ENABLE_FB_NOTIFY"] != "enable"

      platform.send
      ticket.notified!
    end

    private
      def platform
        klazz = ticket.platform_name
        "Channel::#{klazz}Channel".constantize.new(ticket)
      rescue
        EmptyChannel.new
      end

      def text_message
        template = Tilt::LiquidTemplate.new { response_template.content }
        template.render
      end

      def response_template
        type = "#{ticket.platform_name}Template"

        @response_template ||= Template.find_by(type: type, status: ticket.status)
      end
  end
end
