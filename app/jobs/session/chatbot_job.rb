class Session::ChatbotJob < ApplicationJob
  # in chatbot session_id = messenger_user_id
  def perform(name, value, session_id)
    SessionService.create('Messenger', session_id) do |session|
      session.add_value(name, value).append_steps
    end
  end
end
