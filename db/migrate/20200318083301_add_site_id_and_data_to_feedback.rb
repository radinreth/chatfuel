# frozen_string_literal: true

class AddSiteIdAndDataToFeedback < ActiveRecord::Migration[6.0]
  def change
    add_column :feedbacks, :site_id, :integer
    add_column :feedbacks, :data, :jsonb
  end
end
