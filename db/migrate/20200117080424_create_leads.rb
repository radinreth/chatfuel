class CreateLeads < ActiveRecord::Migration[6.0]
  def change
    create_table :leads do |t|
      t.string :mid
      t.string :first_name
      t.string :gender

      t.timestamps
    end
  end
end
