class RemoveTypeFromVariables < ActiveRecord::Migration[6.0]
  def change
    remove_column :variables, :type
  end
end
