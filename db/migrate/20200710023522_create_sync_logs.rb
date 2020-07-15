class CreateSyncLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :sync_logs do |t|
      t.integer :site_id
      t.string  :status

      t.timestamps
    end
  end
end
