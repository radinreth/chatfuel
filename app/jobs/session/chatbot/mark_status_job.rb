class Session::Chatbot::MarkStatusJob < ApplicationJob
  def perform(messenger_user_id)
    session = Session.find_by(session_id: messenger_user_id)
    session.completed! if session.present?
  end
end
