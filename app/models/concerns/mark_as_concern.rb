# frozen_string_literal: rue

module MarkAsConcern
  extend ActiveSupport::Concern

  WHITELIST_MARK_AS_FEEDBACK = Array.wrap(Variable::FEEDBACK)
  WHITELIST_MARK_AS_WITHOUT_FEEDBACK = %w(gender visualize_gender most_request user_visit location ticket_tracking service_accessed)
  WHITELIST_MARK_AS = WHITELIST_MARK_AS_FEEDBACK + WHITELIST_MARK_AS_WITHOUT_FEEDBACK

  define_method :feedback? do self.mark_as == Variable::FEEDBACK end
  define_method :mark_as_feedback! do update(mark_as: Variable::FEEDBACK) end

  WHITELIST_MARK_AS_WITHOUT_FEEDBACK.each do |item|
    define_method "#{item}?".to_sym do self.mark_as == item end
    define_method "mark_as_#{item}".to_sym do self.mark_as = item end
    define_method "mark_as_#{item}!".to_sym do
      # reset previous variable
      prev = Variable.send(item.to_sym)
      prev.update(mark_as: "")

      # mark new variable
      update(mark_as: item)
    end
  end

  module ClassMethods
    define_method :feedback do find_by(mark_as: Variable::FEEDBACK) end

    WHITELIST_MARK_AS_WITHOUT_FEEDBACK.each do |item|
      define_method "#{item}".to_sym do find_by(mark_as: item) end
    end
  end
end
