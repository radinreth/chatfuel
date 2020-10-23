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
    ActiveRecord::Base.transaction do
      # messenger
      no_basic_info_text_messages = Message.where(platform_name: "Messenger", province_id: nil, district_id: nil, gender: "")
      no_basic_info_text_messages.find_each do |message|
        prev_message =  Message.where(content_type: "TextMessage", content_id: message.content_id)\
                                .find_by("province_id IS NOT NULL AND district_id IS NOT NULL AND gender != ''")

        if prev_message.present?
          message.province_id = prev_message.province_id
          message.district_id = prev_message.district_id
          message.gender = prev_message.gender
          message.save
        end
      end

      # verboice
      no_basic_info_voice_messages = Message.where(platform_name: "Verboice").where(gender: "")
      phones = no_basic_info_voice_messages.inject({}) { |h, m| h[m.id] = m.content.address; h }

      phones.each do |message_id, phone|
        message_ids = VoiceMessage.where(address: phone).map { |m| m.message.id }
        prev_message = Message.where(id: message_ids).where.not(gender: "").first

        if prev_message.present?
          message = Message.find(message_id)
          message.update!(gender: prev_message.gender)
        end
      end
    end
  end
end
