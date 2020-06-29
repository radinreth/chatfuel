class AddLocationToTextMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :text_messages, :location_name, :string
  end
end
