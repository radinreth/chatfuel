class AddColumnsToSyncLogs < ActiveRecord::Migration[6.0]
  def change
    remove_column :sync_logs, :status
    add_column :sync_logs, :status, :integer
    add_column :sync_logs, :uuid, :string
    add_column :sync_logs, :payload, :hstore, default: {}, using: :gin
    add_column :sync_logs, :success_count, :integer, default: 0
    add_column :sync_logs, :failure_count, :integer, default: 0
  end
end
