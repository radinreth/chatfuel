class AddActivityToLead < ActiveRecord::Migration[6.0]
  def change
    remove_reference :activities, :user
    add_reference :activities, :lead, null: false, foreign_key: true
  end
end
