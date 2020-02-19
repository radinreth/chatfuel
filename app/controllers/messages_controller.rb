class MessagesController < ApplicationController
  before_action :set_message
  before_action :set_step

  def create
    head :ok
  end

  private

  def set_message
    messenger_user_id = params[:messenger_user_id]
    content = TextMessage.find_or_create_by(messenger_user_id: messenger_user_id)
    @message = Message.create_or_return(content)
  end

  def set_step
    @set_step ||= @message.steps.create(act: params[:act], value: params[:value])
  end
end
