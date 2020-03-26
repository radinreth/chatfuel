class AddVariableValueToRating < ActiveRecord::Migration[6.0]
  def change
    add_reference :ratings, :variable_value, null: false, foreign_key: true
  end
end
