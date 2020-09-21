# frozen_string_literal: true

require "rails_helper"

RSpec.describe AlertNotificationJob, type: :job do
  describe "#perform_later" do
    let!(:variable) { create(:variable, marks_as: ['report'])}
    let!(:variable_value) { create(:variable_value, raw_value: 'good', variable: variable) }
    let!(:site_setting) { create(:site_setting, message_frequency: 1) }
    let!(:message) { create(:message, feedback_location_code: site_setting.site.code) }
    let!(:step_value) { build(:step_value, message: message, variable_value: variable_value, variable: variable) }

    it "should send push notification" do
      ActiveJob::Base.queue_adapter = :test

      expect {
        AlertNotificationJob.perform_later(step_value.id)
      }.to have_enqueued_job.with(step_value.id).at(:no_wait)
    end
  end
end
