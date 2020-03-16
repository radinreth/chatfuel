class UpdateFeedbacks < ActiveRecord::Migration[6.0]
  def up
    change_table :feedbacks do |t|
      t.string :difficulty
      t.string :additional_info
      t.string :overall
      t.string :efficiency
      t.string :working_time
      t.string :attitude
      t.string :provide_info
      t.string :process
    end

    add_reference :feedbacks, :site
    remove_column :feedbacks, :media_url
    remove_column :feedbacks, :status
  end
end
