module Bots::Tracks
  class ChatbotController < ::Bots::TracksController
    before_action :set_template

    def create
      if params[:platform_name].present? && @ticket
        render json: bot_response, status: :ok
      else
        render json: invalid_response, status: :not_found
      end
    end

    private
      def bot_response
        platform_name = params[:platform_name].to_s.downcase
        platform_name == "messenger" ? messenger_response : telegram_response
      end

      def messenger_response
        {
          "messages": [
            { "attachment": attachment },
            { "text": @template.content }
          ]
        }
      end

      def attachment
        attachment_url = helpers.asset_url("ticket-responses/#{@template.status}")

        {
          "type": "image",
          "payload": { "url": attachment_url }
        }
      end

      def telegram_response
        { "messages": @template.content }
      end

      def set_template
        type = "#{params[:platform_name]}Template"
        @template = Template.find_by!(status: @ticket.progress_status, type: type)
      rescue
        @template = OpenStruct.new content: I18n.t("templates.not_available", status: "wrong-id")
      end
  end
end
