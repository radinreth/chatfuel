class AddDeletedAtToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :deleted_at, :datetime
    add_index :sites, :deleted_at
  end
end
