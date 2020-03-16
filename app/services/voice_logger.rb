# frozen_string_literal: true

class VoiceLogger
  attr_reader :call_id

  def initialize(call_id)
    @email = ENV["VERBOICE_USER"]
    @password = ENV["VERBOICE_PWD"]
    @endpoint = "http://verboice.com/api2"
    @call_id = call_id
  end

  def call
    params = { email: email, token: token }
    call_url = "#{endpoint}/call_logs/#{@call_id}"
    call_log = RestClient.get(call_url, params: params)
    JSON.parse(call_log)
  end

  private
    attr_reader :email
    attr_reader :password
    attr_reader :endpoint

    def token
      response = RestClient.post "#{endpoint}/auth", payload, header
      @token ||= JSON.parse(response.body)["auth_token"]
    end

    def payload
      @payload ||= { "account": {
        "email": email,
        "password": password
      } }
    end

    def header
      @header ||= {
        content_type: :json,
        accept: :json
      }
    end
end
