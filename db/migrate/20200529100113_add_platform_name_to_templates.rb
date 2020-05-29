class AddPlatformNameToTemplates < ActiveRecord::Migration[6.0]
  def change
    add_column :templates, :platform_name, :string, null: false
  end
end
