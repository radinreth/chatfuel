class AddRepeatedToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :repeated, :boolean, default: false
  end
end
