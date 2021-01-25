# frozen_string_literal: true

module Api
  module V1
    class ChatbotTracksController < ApplicationController
      include Trackable

      before_action :json_response

      def show
        set_attributes

        prepend_title if schedule_request?
        remove_messages if schedule_request? && !@ticket.completed?

        render json: @json_response, status: :ok
      end

      private

      # For schedule request,
      # No need to respond if it's still incomplete or incorrect
      def remove_messages
        @json_response.delete(:messages)
      end

      def schedule_request?
        params[:is_schedule_request] == "true"
      end

      # To memoir, which ticket code is being schedule?
      # by appending the title above the status of ticket
      def prepend_title
        title = t("chatbot_resp_title", code: params[:code], locale: :km)
        @json_response[:messages].prepend(text: title)
      end

      def set_attributes
        @json_response[:set_attributes] = {
          ticket_status: ticket_status
        }
      end

      def json_response
        template = Template.for(ticket_status, params[:platform_name])

        @json_response = (template.present? ? template.json_response : missing_response)
      end

      def missing_response
        Template.send_missing_response(ticket_status, params[:platform_name])
      end

      def ticket_status
        @ticket.nil? ? :incorrect : @ticket.progress_status
      end
    end
  end
end
