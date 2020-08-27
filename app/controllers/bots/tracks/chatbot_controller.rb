module Bots::Tracks
  class ChatbotController < ::Bots::TracksController
    def create
      super

      render json: json_response, status: :ok
    end

    private

    def json_response
      template = Template.for(ticket_status, params[:platform_name])

      return template.json_response if template

      Template.send_missing_response(ticket_status, params[:platform_name])
    end

    def ticket_status
      @ticket.nil? ? :incorrect : @ticket.progress_status
    end
  end
end
