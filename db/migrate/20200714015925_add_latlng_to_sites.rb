class AddLatlngToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :lat, :string, default: ""
    add_column :sites, :lng, :string, default: ""
  end
end
