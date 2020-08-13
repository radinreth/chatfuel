class DropTableSyncHistoryLogs < ActiveRecord::Migration[6.0]
  def change
    drop_table :sync_history_logs
  end
end
