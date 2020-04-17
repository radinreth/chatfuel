class CreateTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :templates do |t|
      t.string :content, default: ""

      t.timestamps
    end
  end
end
