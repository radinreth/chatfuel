# frozen_string_literal: rue

module MarkAsConcern
  extend ActiveSupport::Concern

  WHITELIST_MARKS_AS = %w(report most_request user_visit location ticket_tracking service_accessed)

  WHITELIST_MARKS_AS.each do |item|
    define_method "#{item}?".to_sym do self.mark_as == item end
    define_method "mark_as_#{item}!".to_sym do update(mark_as: item) end
  end

  module ClassMethods
    WHITELIST_MARKS_AS.each do |item|
      define_method "#{item}".to_sym do find_by(mark_as: item) end
    end
  end
end
