class AddActivedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :actived, :boolean
  end
end
