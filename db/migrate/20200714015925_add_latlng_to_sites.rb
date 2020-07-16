class AddLatlngToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :lat, :float
    add_column :sites, :lng, :float
  end
end
