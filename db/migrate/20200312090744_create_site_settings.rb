# frozen_string_literal: true

class CreateSiteSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :site_settings do |t|
      t.text :message_template

      t.timestamps
    end
  end
end
