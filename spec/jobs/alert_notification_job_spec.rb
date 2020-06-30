# frozen_string_literal: true

require "rails_helper"

RSpec.describe AlertNotificationJob, type: :job do
  describe "#perform_later" do
    it "should send push notification" do
      variable = create(:variable, feedback_message: true)
      variable_value = create(:variable_value, variable_id: variable.id)
      setting = create(:site_setting, message_frequency: 1)
      step_value = create(:step_value, variable_value: variable_value, site: setting.site )

      ActiveJob::Base.queue_adapter = :test

      expect {
        AlertNotificationJob.perform_later(step_value.id)
      }.to have_enqueued_job.with(step_value.id).at(:no_wait)
    end
  end
end
