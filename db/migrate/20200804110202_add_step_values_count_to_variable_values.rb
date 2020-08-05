class AddStepValuesCountToVariableValues < ActiveRecord::Migration[6.0]
  def change
    add_column :variable_values, :step_values_count, :integer, default: 0

    Rake::Task['variable_value:migreate_step_values_count'].invoke
  end
end
