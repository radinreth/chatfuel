class CreateVoiceAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :voice_answers do |t|
      t.string :project_variable_name
      t.string :value
      t.belongs_to :voice_message, index: true

      t.timestamps
    end
  end
end
