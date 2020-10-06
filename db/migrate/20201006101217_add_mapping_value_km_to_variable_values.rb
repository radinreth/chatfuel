class AddMappingValueKmToVariableValues < ActiveRecord::Migration[6.0]
  def change
    # TODO: leave it blank or migrate from mapping_value_en
    add_column :variable_values, :mapping_value_km, :string, default: ""
  end
end
