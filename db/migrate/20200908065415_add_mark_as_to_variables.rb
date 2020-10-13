class AddMarkAsToVariables < ActiveRecord::Migration[6.0]
  def change
    add_column :variables, :mark_as, :string, default: ""
    add_index :variables, :mark_as
  end
end
