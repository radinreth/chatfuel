class ChangeColumnSyncStatusInSites < ActiveRecord::Migration[6.0]
  def change
    change_column :sites, :sync_status, :integer, default: nil, null: true
  end
end
