class Session::Chatbot::MarkStatusJob < ApplicationJob
  sidekiq_options queue: :default

  discard_on ActiveJob::DeserializationError
  retry_on ActiveRecord::Deadlocked, wait: 5.seconds, attempts: 3

  def perform(messenger_user_id)
    session = Session.find_by(session_id: messenger_user_id)
    session.completed! if session.present?
  end
end
