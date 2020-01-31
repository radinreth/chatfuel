class VoiceMessagesController < ApplicationController
  def create
    @voice = VoiceMessage.create voice_message_params
    email = 'radin@instedd.org'
    password = 'q1p2m3g4'
    response = RestClient.post 'verboice.com/api2/auth', {"account": {"email": email, "password": password}}, {content_type: :json, accept: :json}
    token = JSON.parse(response.body)["auth_token"]
    
    call_log = RestClient.get('verboice.com/api2/call_logs/281820', params: {email: email, token: token})
    answers = JSON.parse(call_log)["call_log_anwsers"]
  end

  private

  def voice_message_params
    params.permit(:CallSid, :address)
  end
end
