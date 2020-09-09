namespace :variable do
  desc "Merge boolean options that represent marks_as into one"

  task merge_marks_as_options: :environment do
    bool_columns = <<-SQL
      report_enabled=true or
      is_most_request=true or
      is_user_visit=true or
      is_location=true or
      is_ticket_tracking=true or
      is_service_accessed=true
    SQL

    ActiveRecord::Base.transaction do
      Variable.where(bool_columns).each do |variable|
        variable.marks_as = []
        variable.marks_as << 'report' if variable.report_enabled?
        variable.marks_as << 'most_request' if variable.is_most_request?
        variable.marks_as << 'user_visit' if variable.is_user_visit?
        variable.marks_as << 'location' if variable.is_location?
        variable.marks_as << 'ticket_tracking' if variable.is_ticket_tracking?
        variable.marks_as << 'service_accessed' if variable.is_service_accessed?

        variable.save
      end
    end
  end
end
