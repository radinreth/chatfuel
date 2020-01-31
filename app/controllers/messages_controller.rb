class MessagesController < ApplicationController
  before_action :log_console
  before_action :set_message, only: [:create, :done, :continue]
  before_action :set_step, only: [:create, :done, :continue]
  # skip_before_action :verify_authenticity_token

  def create
    head :ok
  end

  def done
    render json: done_response
  end

  def continue
    render json: continue_response
  end

  private

  def continue_response
    {
      "redirect_to_blocks": [@message.last_step.to_block]
    }
  end

  def done_response
    {
      "messages": [
        { "text": 'Your result is:' },
        { "text": "your info: #{@message.last_step.act}-#{@message.last_step.value}" }
      ]
    }
  end

  def log_console
    logger.warn action_name
    logger.info params.inspect
  end

  def set_message
    text_message ||= TextMessage.find_or_create_by(messenger_user_id: params[:messenger_user_id]) do |message|
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

    @message ||= Message.find_or_create_by content: text_message
  end

  def set_step
    @set_step ||= @message.steps.build(act: params[:act], value: params[:value])

    unless @set_step.save
      render json: @step.errors, status: :unprocessable_entity
    end
  end
end
