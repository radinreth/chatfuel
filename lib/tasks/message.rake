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
    end
  end
  
  desc "Migrate message to session"
  task migrate_to_session: :environment do
    return unless defined? Message

    ActiveRecord::Base.transaction do
      Message.find_each do |message|
        Session.create! do |session|
          session.id = message.id
          session.session_id = message.session_id
          session.platform_name = message.platform_name
          session.status = message.status
          session.district_id = message.district_id
          session.province_id = message.province_id
          session.last_interaction_at = message.last_interaction_at
          session.created_at = message.created_at
          session.updated_at = message.updated_at
        end
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

  desc "Migrate tracking where step values belongs to ticket tracking"
  task migrate_tracking: :environment do
    tracking_variable = Variable.find_by(is_ticket_tracking: true)

    return if tracking_variable.blank?

    ActiveRecord::Base.transaction do
      tracking_variable.step_values.find_each do |step_value|
        Tracking.create! do |t|
          t.ticket_code = step_value.variable_value.raw_value
          t.site_code = step_value.variable_value.raw_value[0...4]
          t.status = step_value.variable_value.ticket_status
          t.tracking_datetime = step_value.created_at
          t.message = step_value.message
        end
      rescue => e
        puts "-> #{e.message}"
        break
      end
    end
  end
end
