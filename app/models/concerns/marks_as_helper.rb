# frozen_string_literal: rue

module MarksAsHelper
  WHITELIST_MARKS_AS = %w(report most_request user_visit location ticket_tracking service_accessed)

  WHITELIST_MARKS_AS.each do |method|
    define_method method.to_sym do
      find_by("'#{method}' = ANY (marks_as)")
    end
  end
end
