class AddMarkAsToVariables < ActiveRecord::Migration[6.0]
  def up
    add_column :variables, :mark_as, :string, default: ""
    add_index :variables, :mark_as
    Rake::Task['variable:mark_as:merge'].invoke
  end

  def down
    Rake::Task['variable:mark_as:split'].invoke
    remove_column :variables, :mark_as
  end
end
