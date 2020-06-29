module Bots
  class LocationsController < BotsController
    before_action :set_message

    def create
      head :ok
    end

    private

    def set_message
      content = TextMessage.find_or_create_by(messenger_user_id: params[:messenger_user_id], location_name: params[:location_name])
      @message = Message.create_or_return(params[:platform_name], content)
    end
  end
end
