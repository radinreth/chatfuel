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

  desc "Migrate missing gender when start new session"
  task migrate_missing_gender_on_new_session: :environment do
    ActiveRecord::Base.record_timestamps = false

    ActiveRecord::Base.transaction do
      # messenger
      no_basic_info_text_messages = Message.where(platform_name: "Messenger", province_id: nil, district_id: nil, gender: "")
      no_basic_info_text_messages.find_each do |message|
        last_prev_message =  message.last_completed

        if last_prev_message.present?
          message.province_id = last_prev_message.province_id
          message.district_id = last_prev_message.district_id
          message.gender = last_prev_message.gender
          message.save
        end
      end

      StepValue.where(session_id: nil).find_each do |step_value|
        step_value.session_id = step_value.message_id
        # step_value.message_id = nil
        step_value.save
      end
    end

  ensure
    ActiveRecord::Base.record_timestamps = true
  end

  desc "Migrate last interaction date to default CURRENT_TIMESTAMP (database level)"
  task :migrate_last_interaction_at, [:datetime] => :environment do |t, args|
    wrong_default_migration_date = "2020-08-03 03:01:25"
    datetime = args[:datetime] || wrong_default_migration_date

    Message.where(" DATE(last_interaction_at) < DATE(updated_at) AND
                    DATE(last_interaction_at)=?", datetime).find_each do |message|
      message.update(last_interaction_at: message.updated_at)
    end
  end
end
