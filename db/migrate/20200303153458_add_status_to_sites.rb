class AddStatusToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :status, :integer, default: 0
  end
end
