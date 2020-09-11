class AddMappingNameToVariables < ActiveRecord::Migration[6.0]
  def change
    add_column :variables, :mapping_name, :string, default: ""
  end
end
