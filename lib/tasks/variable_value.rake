# frozen_string_literal: true

namespace :variable_value do
  desc 'migrate step_values_count in variable_values table'
  task migreate_step_values_count: :environment do
    VariableValue.all.find_each do |value|
      VariableValue.reset_counters(value.id, :step_values)
    end
  end

  desc "Remove raw value null"
  task remove_null_value: :environment do
    variable_values = VariableValue.unscoped.where(raw_value: 'null')
    step_values = StepValue.where(variable_value_id: variable_values.ids)

    step_values.destroy_all
    variable_values.destroy_all
  end
end
