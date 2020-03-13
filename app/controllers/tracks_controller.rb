class TracksController < ApplicationController
  skip_before_action :authenticate_user_without_guisso!
  skip_before_action :verify_authenticity_token
  before_action :message
  before_action :ticket
  after_action :assign_track_to_step

  def create
    @track = Track.new(track_params)

    if @track.save
      @site = Site.find_by(code: @track.site_code)
      @track.update(site: @site, ticket: @ticket)
      render json: json_response, status: :ok
    end
  end

  private

  def json_response
    {
      "messages": [
        { "text": decorator.status },
        { "text": decorator.description }
      ]
    }
  end

  def decorator
    @decorator ||= TicketDecorator.new(ticket || invalid_ticket)
  end

  def ticket
    @ticket ||= Ticket.find_by(code: params[:code])
  end

  def invalid_ticket
    @invalid_ticket ||= OpenStruct.new(status: 'invalid')
  end

  def assign_track_to_step
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
