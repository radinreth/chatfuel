class AddGenderToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :gender, :string, default: ""
  end
end
