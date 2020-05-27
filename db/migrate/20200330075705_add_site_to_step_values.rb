class AddSiteToStepValues < ActiveRecord::Migration[6.0]
  def change
    add_reference :step_values, :site, foreign_key: true
  end
end
