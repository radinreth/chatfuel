class SessionJob < ApplicationJob
  sidekiq_options queue: :default

  discard_on ActiveJob::DeserializationError
  retry_on ActiveRecord::Deadlocked, wait: 5.seconds, attempts: 3

  def perform(name, value, messenger_user_id)
    SessionService.create(messenger_user_id) do |session|
      session.add_value(name, value).append_steps
    end
  end
end
