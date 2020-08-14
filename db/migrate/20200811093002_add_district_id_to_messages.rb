class AddDistrictIdToMessages < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :district_id, :string, limit: 8
  end
end
