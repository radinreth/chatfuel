module Bots::Tracks
  class ChatbotController < ::Bots::TracksController
    before_action :json_response

    def create
      set_attributes

      # remove if incomplete or incorrect
      # remove_messages if schedule_request? && !@ticket.complete?
      prepend_title if schedule_request?

      render json: @json_response, status: :ok
    end

    private

    def schedule_request?
      params[:is_schedule_request] == "true"
    end

    def prepend_title
      title = t("chatbot_resp_title", code: params[:code], locale: :km)
      @json_response[:messages].prepend(text: title)
    end

    def set_attributes
      {
        set_attributes: { ticket_status: ticket_status }
      }
    end

    def json_response
      template = Template.for(ticket_status, params[:platform_name])

      @json_response = template ? template.json_response : missing_response
    end

    def missing_response
      Template.send_missing_response(ticket_status, params[:platform_name])
    end

    def ticket_status
      @ticket.nil? ? :incorrect : @ticket.progress_status
    end
  end
end
