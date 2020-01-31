class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.string :variable_name
      t.string :value
      t.references :voice_message, null: false, foreign_key: true

      t.timestamps
    end
  end
end
