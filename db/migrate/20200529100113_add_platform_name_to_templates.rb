class AddPlatformNameToTemplates < ActiveRecord::Migration[6.0]
  def change
    # add_column :templates, :platform_name, :string, default: "0"
    add_column :templates, :status, :string, default: "0"
    add_column :templates, :type, :string, null: false
  end
end
