class AddMarkAsToVariables < ActiveRecord::Migration[6.0]
  def change
    add_column :variables, :marks_as, :string, array: true
    add_index :variables, :marks_as, using: :gin
  end
end
