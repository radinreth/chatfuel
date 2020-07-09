class ChangeColumnRoleIdInUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :role
    change_column :users, :role_id, :integer, default: nil, null: true
  end
end
