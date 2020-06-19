class AddSyncStatusToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :sync_status, :string, null: false, default: "1"
  end
end
