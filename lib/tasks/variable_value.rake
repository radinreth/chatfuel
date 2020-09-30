# frozen_string_literal: true

namespace :variable_value do
  desc 'migrate step_values_count in variable_values table'
  task migreate_step_values_count: :environment do
    VariableValue.all.find_each do |value|
      VariableValue.reset_counters(value.id, :step_values)
    end
  end

  desc "Remove raw value null from variable value"
  task remove_null_value: :environment do
    null_values = VariableValue.unscoped.where(raw_value: 'null')
    null_values.destroy_all
  end
end
