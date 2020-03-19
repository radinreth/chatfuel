# frozen_string_literal: true

require "rails_helper"

RSpec.describe AlertNotificationJob, type: :job do
  describe "#perform_later" do
    let(:setting_id) { 1 }
    let(:message) { "notification message detail" }

    it "should send push notification" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        AlertNotificationJob.perform_later(setting_id, message)
      }.to have_enqueued_job.with(setting_id, message).on_queue(:default).at(:no_wait)
    end
  end
end
