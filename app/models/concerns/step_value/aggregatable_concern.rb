require 'csv'

module StepValue::AggregatableConcern
  extend ActiveSupport::Concern

  module ClassMethods
    def self.total_users_visit_each_functions(params = {})
      key = "mapping_value_#{ I18n.locale }".to_sym
      scope = filter(scope, params)
      scope = scope.joins(variable_value: :variable)
      scope = scope.where(variable_id: Variable.user_visit)
      scope = scope.order(key)
      scope = scope.group(key)
      scope.count
    end

    def self.total_users_feedback(params = {})
      feedback_variable = Variable.feedback
      params = params.merge(variable: feedback_variable) if feedback_variable
      
      statuses = VariableValue.statuses
      default = statuses.transform_values { 0 }

      scope = filter(scope, params)
      result = scope.joins(:variable_value).group(:status).count.map do |k, v|
        [statuses.key(k), v]
      end.to_h

      default.merge(result).transform_keys { |k| I18n.t(k.downcase.to_sym) }
    end

    def self.users_visited_by_each_genders(params = {})
      scope = joins(:message).where.not(messages: { gender: '' })
      scope = scope.where(variable_value: VariableValue.kind_of_criteria)
      scope = filter(scope, params)
    end
  end
end
