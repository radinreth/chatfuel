module Bots
  class TracksController < BotsController
    before_action :set_message
    before_action :set_site
    before_action :set_ticket
    before_action :set_track
    before_action :set_step

    def create
      render json: send("#{params[:bot_platform]}_response".to_sym), status: :ok
    end

    private
      def set_track
        @track = Track.create(code: params[:code], site: @site, ticket: @ticket)
      end

      def set_step
        @step = @message.steps.build(track: @track)
        @step.save
      end

      def _response
        {
          "messages": [
            { "text": decorator.status },
            { "text": decorator.description }
          ]
        }
      end

      def telegram_response
        { "messages": "#{decorator.status}. #{decorator.description}" }
      end

      def decorator
        @decorator ||= TicketDecorator.new(@ticket || invalid_ticket)
      end

      def invalid_ticket
        @invalid_ticket ||= OpenStruct.new(status: "invalid")
      end

      def normalized_code
        begin
          code = params[:code]
          code.insert(4, "-") if code[4] != "-"
          code
        rescue
          code
        end
      end
  end
end
