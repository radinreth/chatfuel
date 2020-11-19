class AddRepeatedToSession < ActiveRecord::Migration[6.0]
  def change
    add_column :sessions, :repeated, :boolean, default: false
  end
end
