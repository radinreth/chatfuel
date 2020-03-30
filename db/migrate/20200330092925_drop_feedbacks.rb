class DropFeedbacks < ActiveRecord::Migration[6.0]
  def change
    drop_table :ratings
    drop_table :feedbacks
  end
end
