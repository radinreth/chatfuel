class AddSyncStatusTokenToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :sync_status, :string, null: false, default: "1"
    add_column :sites, :token, :string, default: ""
  end
end
