class AddPlatformNameToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :platform_name, :string, default: ""
  end
end
