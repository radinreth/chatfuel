class AddSiteToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :site
  end
end
