namespace :message do
  desc "Update message district_id when location variable change"

  task migrate_district_id: :environment do
    location_variable = Variable.find_by(is_location: true)

    return if location_variable.nil?

    ActiveRecord::Base.transaction do
      StepValue.where(variable: location_variable).find_each do |s|
        s.touch if s.message && s.message.district_id
      end
    end
  end

  desc "Migrate trackings from step values"
  task migrate_tracking: :environment do
    tracking_variable = Variable.find_by(is_ticket_tracking: true)

    tracking_variable.step_values.each do |step|
      ActiveRecord::Base.transaction do
        Tracking.create! do |t|
          t.status = step.variable_value.ticket_status
          t.message = step.message
          t.tracking_datetime = step.created_at
        end
      end

      rescue => e
        puts "#{step.id} #{e.message}"
    end
  end
end
