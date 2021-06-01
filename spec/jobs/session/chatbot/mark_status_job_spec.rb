require 'rails_helper'

RSpec.describe Session::Chatbot::MarkStatusJob, type: :job do
  it 'enqueues a job' do
    expect {
      Session::Chatbot::MarkStatusJob.perform_later
    }.to have_enqueued_job.on_queue('default')
  end
end
