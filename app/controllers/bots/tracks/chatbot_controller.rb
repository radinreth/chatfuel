module Bots::Tracks
  class ChatbotController < ::Bots::TracksController
    def create
      render json: json_response, status: :ok
    end

    private

    def json_response
      template = Template.for(ticket_status, params[:platform_name])

      return template.json_response if template

      OpenStruct.new(content: I18n.t("tickets.#{ticket_status}.content", locale: :km))
    end

    def ticket_status
      @ticket.nil? ? :incorrect : @ticket.progress_status
    end
  end
end
