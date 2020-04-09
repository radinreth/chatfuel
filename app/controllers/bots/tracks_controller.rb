module Bots
  class TracksController < BotsController
    before_action :set_message
    before_action :set_site
    before_action :set_ticket
    before_action :set_track
    before_action :set_step

    def create
      render json: json_response, status: :ok
    end

    private
      def set_track
        @track = Track.new(code: params[:code], site: @site, ticket: @ticket)
      end

      def set_step
        @step = @message.steps.create(track: @track)
      end

      def json_response
        {
          "messages": [
            { "text": decorator.status },
            { "text": decorator.description }
          ]
        }
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
