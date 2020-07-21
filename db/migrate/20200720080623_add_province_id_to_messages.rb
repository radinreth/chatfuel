class AddProvinceIdToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :province_id, :string
  end
end
