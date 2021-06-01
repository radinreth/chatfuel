class Session::ChatbotJob < ApplicationJob
  sidekiq_options queue: :default

  discard_on ActiveJob::DeserializationError
  retry_on ActiveRecord::Deadlocked, wait: 5.seconds, attempts: 3

  # in chatbot session_id = messenger_user_id
  def perform(name, value, session_id)
    SessionService.create('Messenger', session_id) do |session|
      session.add_value(name, value).append_steps
    end
  end
end
