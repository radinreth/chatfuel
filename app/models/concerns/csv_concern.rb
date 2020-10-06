require 'csv'

module CsvConcern
  extend ActiveSupport::Concern

  def to_csv(variables)
    row = []

    row << session_id
    row << created_at
    row << field_values(variables)

    row
  end

  def field_values(variables)
    list = []

    variables.each do |field|
      value = ""
      step_values.each do |step_value|
        if field.name == step_value.variable.name
          value = step_value.variable_value.mapping_value_en
          break
        end
      end
      list << value
    end

    list
  end

  module ClassMethods
    def to_csv(results, variables)
      CSV.generate("\uFEFF", encoding: 'ISO-8859-1') do |csv|
        csv << csv_header(variables)
        results.each do |result|
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
