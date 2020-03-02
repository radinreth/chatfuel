class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.integer :status, default: 0
      t.string :media_url
      t.belongs_to :step

      t.timestamps
    end
  end
end
