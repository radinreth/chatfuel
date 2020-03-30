module Bots
  class TracksController < BotsController
    before_action :set_message
    before_action :set_site
    before_action :set_ticket
    before_action :set_track
    before_action :set_step

    def create
      render json: send("#{@message.platform_name.downcase}_response".to_sym), status: :ok
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
        @_resp ||= {
          "messages": [
            { "text": decorator.status },
            { "text": decorator.description }
          ]
        }

        @_resp[:messages].push(resp_attachment) if decorator.invalid?
        @_resp
      end
      alias_method :messenger_response, :_response

      def resp_attachment
        {
          "attachment": {
            "type": "image",
            "payload": {
              "url": "https://rockets.chatfuel.com/assets/welcome.png"
            }
          }
        }
      end

<<<<<<< HEAD
      def telegram_response
        { "messages": "#{decorator.status}. #{decorator.description}" }
      end

      def decorator
        @decorator ||= TicketDecorator.new(@ticket || invalid_ticket)
=======
      def ticket
        @ticket ||= Ticket.find_by(code: refined_code)
>>>>>>> Refactor message
      end

      def invalid_ticket
        @invalid_ticket ||= OpenStruct.new(status: "invalid")
      end

<<<<<<< HEAD
      def normalized_code
        begin
          code = params[:code]
          code.insert(4, "-") if code[4] != "-"
          code
        rescue
          code
        end
=======
      def assign_track_to_step
        return unless @track.persisted?

        message = Message.find_by(content: @message)

        # TODO: no need to setup steps
        message.steps.create(act: "tracking_ticket", value: refined_code, track: @track)
>>>>>>> Refactor message
      end

      def refined_code
        code = params[:code]
        code[4] = "-" if code[4] != "-"
        code
      end

      def refined_code
        code = params[:code]
        code[4] = "-" if code[4] != "-"
        code
      end
  end
end
