class AddSiteIdToSyncHistoryLogs < ActiveRecord::Migration[6.0]
  def change
    add_column :sync_history_logs, :site_id, :integer
  end
end
