# frozen_string_literal: rue

module MarksAsHelper
  extend ActiveSupport::Concern

  WHITELIST_MARKS_AS = %w(report most_request user_visit location ticket_tracking service_accessed)

  WHITELIST_MARKS_AS.each do |item|
    define_method "#{item}?".to_sym do
      self.marks_as.include? item
    end

    define_method "mark_as_#{item}!".to_sym do
      marks_as << item
      save
    end
  end

  module ClassMethods
    WHITELIST_MARKS_AS.each do |item|
      define_method "#{item}".to_sym do
        find_by("'#{item}' = ANY (marks_as)")
      end
    end
  end
end
