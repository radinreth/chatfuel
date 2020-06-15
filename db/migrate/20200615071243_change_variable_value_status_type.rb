class ChangeVariableValueStatusType < ActiveRecord::Migration[6.0]
  def change
    change_column :variable_values, :status, :string, default: "1"
  end
end
