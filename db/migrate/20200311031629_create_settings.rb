# frozen_string_literal: true

class CreateSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :settings do |t|
      t.text :incompleted_text
      t.text :completed_text

      t.timestamps
    end
  end
end
