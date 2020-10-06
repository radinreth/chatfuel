class AddMappingValueKmToVariableValues < ActiveRecord::Migration[6.0]
  def change
    add_column :variable_values, :mapping_value_km, :string, default: ""
  end
end
