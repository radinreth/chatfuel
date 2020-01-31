class MessagesController < ApplicationController
  before_action :log_console
  before_action :set_message, only: [:create]
  skip_before_action :verify_authenticity_token

  def create
    @step = @set_message.steps.build(act: params[:act], value: params[:value])
    if @step.save
      head :ok
    else
      render json: @step.errors, status: :unprocessable_entity
    end
  end

  private

  def log_console
    logger.warn action_name
    logger.info params.inspect
  end

  def set_message
    @set_message ||= TextMessage.find_or_create_by(messenger_user_id: params[:messenger_user_id]) do |message|
      message.first_name = params[:first_name]
      message.last_name = params[:last_name]
      message.gender = params[:gender]
      message.profile_pic_url = params[:profile_pic_url]
      message.timezone = params[:timezone]
      message.locale = params[:locale]
      message.source = params[:source]
      message.last_seen = params[:last_seen]
      message.signed_up = params[:signed_up]
      message.sessions = params[:sessions]
      message.last_visited_block_name = params[:last_visited_block_name]
      message.last_visited_block_id = params[:last_visited_block_id]
      message.last_clicked_button_name = params[:last_clicked_button_name]
    end

    @message ||= Message.find_or_create_by content: @set_message
  end
end
