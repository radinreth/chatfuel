require 'rails_helper'

RSpec.describe Session::IvrJob, type: :job do
  it 'enqueues a job' do
    expect {
      Session::IvrJob.perform_later
    }.to have_enqueued_job.on_queue('default')
  end
end
