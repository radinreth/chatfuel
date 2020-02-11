class MessagesController < ApplicationController
  #before_action :log_console
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

  def set_message
    content = TextMessage.create_with(
      first_name: params[:first_name],
      last_name: params[:last_name],
      gender: params[:gender],
      profile_pic_url: params[:profile_pic_url],
      source: params[:source],
      sessions: params[:sessions]
    ).find_or_create_by(messenger_user_id: params[:messenger_user_id])

    @message = Message.create_or_update(content)
  end

  def set_step
    @set_step ||= @message.steps.create(act: params[:act], value: params[:value])
  end
end
