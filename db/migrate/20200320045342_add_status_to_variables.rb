class AddStatusToVariables < ActiveRecord::Migration[6.0]
  def change
    add_column :variables, :status, :integer, default: 0
  end
end
