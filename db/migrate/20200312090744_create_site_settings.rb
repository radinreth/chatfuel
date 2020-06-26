# frozen_string_literal: true

class CreateSiteSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :site_settings do |t|
      t.text    :message_template
      t.text    :digest_message_template
      t.integer :message_frequency
      t.boolean :enable_notification, default: false
      t.references :site, null: false, foreign_key: true

      t.timestamps
    end
  end
end
