module Channel
  class BaseChannel
    attr_accessor :url, :template, :params

    def initialize(ticket)
      @ticket = ticket
    end

    def send
      return false if ENV["ENABLE_FB_NOTIFY"] == "disable"
      platform.send
      @ticket.notified!
    end

    private
      def platform
        begin
          klazz = @ticket.platform_name
          "Channel::#{klazz}Channel".constantize.new(@ticket)
        rescue
          EmptyChannel.new
        end
      end

      def text_message
        template = Tilt::LiquidTemplate.new { Template.first.content }
        template.render nil, code: @ticket.code
      end
  end
end
