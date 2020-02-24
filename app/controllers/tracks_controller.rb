class TracksController < ApplicationController
  before_action :message
  after_action :tracking_step

  def create
    @track = Track.new(track_params)

    if @track.save
      @site = Site.find_by(code: @track.site_code)
      @track.update(site: @site)
      render json: json_response, status: :ok
    end
  end

  private

  def json_response
    {
      "messages": [
        {"text": "Ticket #{params[:code]} is #{ticket_status}"},
      ]
    }
  end

  def ticket_status
    ticket = Ticket.find_by(code: params[:code])
    ticket.try(:status) || 'ticket not found'
  end

  def tracking_step
    return unless @track.persisted?

    @message = Message.find_by(content: message)
    @message.steps.create(act: 'tracking_ticket', track: @track)
  end

  def message
    case params[:klass]
    when 'TextMessage' then TextMessage.find_by(messenger_user_id: params[:messenger_user_id])
    when 'VoiceMessage' then VoiceMessage.find_by(callsid: params[:CallSid])
    end
  end

  def track_params
    params.permit(:code)
  end
end
