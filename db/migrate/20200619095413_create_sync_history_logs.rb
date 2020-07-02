class CreateSyncHistoryLogs < ActiveRecord::Migration[6.0]
  def change
    enable_extension "hstore" unless extension_enabled?("hstore")
    create_table :sync_history_logs do |t|
      t.string :uuid, null: false, default: ""
      t.hstore :payload, null: false, default: {}, using: :gin
      t.integer :success_count, default: 0
      t.integer :failure_count, default: 0

      t.timestamps
    end
    add_index :sync_history_logs, :uuid
  end
end
