module Bots
  class TracksController < BotsController
    before_action :set_ticket

    private
      def set_ticket
        @ticket = Ticket.find_by(code: params["code"])
      end

      def invalid_response
        { message: "invalid response" }
      end
  end
end
