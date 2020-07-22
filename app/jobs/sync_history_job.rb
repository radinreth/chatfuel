class SyncHistoryJob < ApplicationJob
  queue_as :default

  def perform(sync_history_log_id)
    sync_history = SyncHistoryLog.find_by(id: sync_history_log_id)

    return if sync_history.nil?

    sync_history.upsert_tickets_to_site
  end
end
