class AddProvinceIdToTextMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :text_messages, :province_id, :string
  end
end
