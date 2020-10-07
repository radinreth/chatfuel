class AddMappingValueKmToVariableValues < ActiveRecord::Migration[6.0]
  def up
    add_column :variable_values, :mapping_value_km, :string, default: ""
    Rake::Task["variable_value:migrate_raw_value_to_mapping_value_km"].execute
  end

  def down
    remove_column :variable_values, :mapping_value_km
  end
end
