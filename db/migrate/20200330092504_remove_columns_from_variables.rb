class RemoveColumnsFromVariables < ActiveRecord::Migration[6.0]
  def change
    remove_column :variables, :status, :integer
    remove_column :variables, :text, :string
    remove_column :variables, :value, :string
  end
end
