class AddPlatformNameToTemplates < ActiveRecord::Migration[6.0]
  def change
    add_column :templates, :platform_name, :string, default: "0"
  end
end
