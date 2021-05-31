require 'rails_helper'

RSpec.describe SessionJob, type: :job do
  it 'enqueues a job' do
    expect {
      SessionJob.perform_later
    }.to have_enqueued_job.on_queue('default')
  end
end
