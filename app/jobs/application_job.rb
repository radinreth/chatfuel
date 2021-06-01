# frozen_string_literal: true

class ApplicationJob < ActiveJob::Base
  sidekiq_options queue: :default

  discard_on ActiveJob::DeserializationError
  retry_on ActiveRecord::Deadlocked, wait: 5.seconds, attempts: 3
end
