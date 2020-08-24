require 'csv'

module CsvConcern
  extend ActiveSupport::Concern

  def to_csv variables
    row = []
    
    row << session_id
    row << created_at
    row << field_values(variables)

    row
  end

  def field_values(variables)
    list = []

    variables.each do |field|
      step_values.most_recent.each do |step_value|
        if field.name == step_value.variable.name
          list << step_value.variable_value.mapping_value
          break
        end
      end
    end

    list
  end

  module ClassMethods
    def to_csv(results, variables)
      CSV.generate do |csv|
        csv << csv_header(variables)

        results.find_each do |result|
          csv << result.to_csv(variables).flatten
        end
      end
    end

    private

    def csv_header(variables)
      ['session_id', 'created_at'] + variables.pluck(:name)
    end
  end
end
