class SyncLogJob < ApplicationJob
  queue_as :default

  def perform(sync_log_id)
    sync_log = SyncLog.find_by(id: sync_log_id)

    return if sync_log.nil?

    sync_log.upsert_tickets
  end
end
