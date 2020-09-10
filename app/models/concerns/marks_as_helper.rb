# frozen_string_literal: rue

module MarksAsHelper
  extend ActiveSupport::Concern

  WHITELIST_MARKS_AS = %w(report most_request user_visit location ticket_tracking service_accessed)

  WHITELIST_MARKS_AS.each do |method|
    define_method "mark_as_#{method}?".to_sym do
      marks_as.include? method
    end
  end

  module ClassMethods
    WHITELIST_MARKS_AS.each do |method|
      define_method "mark_as_#{method}".to_sym do
        find_by("'#{method}' = ANY (marks_as)")
      end
    end
  end
end
