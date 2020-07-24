module Bots::Tracks
  class ChatbotController < ::Bots::TracksController
    before_action :set_template
  
    def create
      render json: bot_response, status: :ok
    end

    private
      def set_template
        return wrong_id unless @ticket

        @template = "#{params[:platform_name]}Template".constantize.find_by(status: @ticket.progress_status)
        if @template.blank?
          @template = OpenStruct.new(content: I18n.t("tickets.#{@ticket.progress_status}.content", locale: :km))
        end
      end

      def wrong_id
        @template = "#{params[:platform_name]}Template".constantize.incorrect.first
        if @template.blank?
          @template = OpenStruct.new(content: I18n.t("tickets.incorrect.content", locale: :km))
        end
      end

      def bot_response
        platform_name == "messenger" ? messenger_response : telegram_response
      end

      def platform_name
        @platform_name = params[:platform_name].to_s.downcase
      end

      def messenger_response
        response = { messages: [] }
        response[:messages] << { attachment: attachment } if attachment
        response[:messages] << { text: @template.content }
        response
      end

      def attachment
        return unless @template.image && @template.image.attached?

        attachment_url = helpers.polymorphic_url(@template.image)
        {
          type: "image",
          payload: { url: attachment_url }
        }
      end

      def telegram_response
        { messages: @template.content }
      end
  end
end
