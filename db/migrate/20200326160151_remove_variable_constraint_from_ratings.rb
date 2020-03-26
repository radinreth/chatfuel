class RemoveVariableConstraintFromRatings < ActiveRecord::Migration[6.0]
  def change
    remove_column :ratings, :variable_id
  end
end
