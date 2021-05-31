require 'rails_helper'

RSpec.describe SessionMarkAsCompleteJob, type: :job do
  it 'enqueues a job' do
    expect {
      SessionMarkAsCompleteJob.perform_later
    }.to have_enqueued_job.on_queue('default')
  end
end
