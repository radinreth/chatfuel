class AddHintToVariableValues < ActiveRecord::Migration[6.0]
  def change
    add_column :variable_values, :hint, :string, limit: 255, default: ""
  end
end
