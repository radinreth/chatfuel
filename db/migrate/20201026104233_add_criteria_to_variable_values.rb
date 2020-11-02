class AddCriteriaToVariableValues < ActiveRecord::Migration[6.0]
  def change
    add_column :variable_values, :is_criteria, :boolean, default: false
  end
end
