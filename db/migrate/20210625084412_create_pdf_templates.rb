class CreatePdfTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :pdf_templates do |t|
      t.string :name, null: false
      t.text :content, default: ""
      t.string :lang_code, default: "en"

      t.timestamps
    end
  end
end
