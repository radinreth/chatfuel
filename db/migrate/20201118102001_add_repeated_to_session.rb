class AddRepeatedToSession < ActiveRecord::Migration[6.0]
  def change
    unless column_exists?(:sessions, :repeated)
      add_column :sessions, :repeated, :boolean, default: false
    end
  end
end
