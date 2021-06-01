require 'rails_helper'

RSpec.describe Session::ChatbotJob, type: :job do
  it 'enqueues a job' do
    expect {
      Session::ChatbotJob.perform_later
    }.to have_enqueued_job.on_queue('default')
  end
end
