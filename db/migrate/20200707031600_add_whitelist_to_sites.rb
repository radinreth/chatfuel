class AddWhitelistToSites < ActiveRecord::Migration[6.0]
  def change
    add_column :sites, :whitelist, :text
  end
end
