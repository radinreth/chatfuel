class SyncHistoryJob < ApplicationJob
  queue_as :default

  def perform(uuid)
    Rails.logger.info "fsdfsd"
    logger.info "Things are happening."
    logger.debug "Here's some info: #{hash.inspect}"
    # Do something later
  end
end
