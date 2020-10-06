class RenameMappingValue < ActiveRecord::Migration[6.0]
  def change
    rename_column :variable_values, :mapping_value, :mapping_value_en
  end
end
