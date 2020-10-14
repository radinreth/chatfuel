namespace :variable do
  namespace :mark_as do
    bool_columns = <<-SQL
      report_enabled=true or
      is_most_request=true or
      is_user_visit=true or
      is_location=true or
      is_ticket_tracking=true or
      is_service_accessed=true
    SQL

    desc "Merge boolean options that represent mark_as into one"
    task merge: :environment do
      ActiveRecord::Base.transaction do
        Variable.where(bool_columns).find_each do |variable|
          variable.update(mark_as: 'report')          if variable.report_enabled?
          variable.update(mark_as: 'most_request')    if variable.is_most_request?
          variable.update(mark_as: 'user_visit')      if variable.is_user_visit?
          variable.update(mark_as: 'location')        if variable.is_location?
          variable.update(mark_as: 'ticket_tracking') if variable.is_ticket_tracking?
          variable.update(mark_as: 'service_accessed') if variable.is_service_accessed?
        end
      end
    end

    desc "Split mark_as into separated columns"
    task split: :environment do
      Variable.where.not(mark_as: nil).find_each do |variable|
        variable.update(report_enabled: true) if variable.report?
        variable.update(is_most_request: true) if variable.most_request?
        variable.update(is_user_visit: true) if variable.user_visit?
        variable.update(is_location: true) if variable.location?
        variable.update(is_ticket_tracking: true) if variable.ticket_tracking?
        variable.update(is_service_accessed: true) if variable.service_accessed?
      end
    end
  end
end
