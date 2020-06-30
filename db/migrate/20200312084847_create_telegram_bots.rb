# frozen_string_literal: true

class CreateTelegramBots < ActiveRecord::Migration[6.0]
  def change
    create_table :telegram_bots do |t|
      t.string :username
      t.string :token
      t.boolean :actived, default: false

      t.timestamps
    end
  end
end
