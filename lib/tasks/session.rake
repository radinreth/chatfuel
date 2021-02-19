require_relative "sessions/fake"
require 'csv'

namespace :session do
  desc "Migrate gender from Message"
  task migrate_gender_from_message: :environment do
    unless defined? Message
      puts "Message model is undefined, Nothing to migrate!"
      exit
    end

    ActiveRecord::Base.record_timestamps = false

    ActiveRecord::Base.transaction do
      Message.find_each do |message|
        session = Session.find_by(session_id: message.session_id)
        session.gender = message.gender
        session.save
      end
    end

  ensure
    ActiveRecord::Base.record_timestamps = true
  end

  desc "Copy attribute session ID to source ID"
  task copy_session_id_to_source_id: :environment do
    unless Session.column_names.include? 'source_id'
      puts "source_id attribute is undefined or no longer exist, Nothing to migrate!"
      exit
    end

    ActiveRecord::Base.record_timestamps = false
    
    ActiveRecord::Base.transaction do
      Session.find_each do |session|
        session.source_id = session.session_id
        session.save
      end
    end
  ensure
    ActiveRecord::Base.record_timestamps = true
  end

  desc "Copy gender from message"
  task copy_gender_from_message: :environment do
    ActiveRecord::Base.record_timestamps = false
    Session.reset_column_information
    ActiveRecord::Base.transaction do
      Message.where.not(gender: ['', nil]).find_each do |message|
        session = Session.find(message.id)
        session.update!(gender: message.gender)
      end
    end
  ensure
    ActiveRecord::Base.record_timestamps = true
  end

  desc "Simulate sessions from kompong chhnang"
  task simulate_data: :environment do
    ActiveRecord::Base.transaction do
      sessions = Session.where.not( province_id: [nil, ""], 
        district_id:[nil, ""], 
        gender: nil).limit(30)

        sessions.find_each do |session|
          cloned_attrib = session.attributes.except("id")
          platform_name, session_id, source_id = random_channel
        
          cloned_attrib["session_id"] = session_id
          cloned_attrib["source_id"] = source_id
          cloned_attrib["platform_name"] = platform_name
          cloned_attrib["gender"] = random_gender
          cloned_attrib["repeated"] = random_repeated
          cloned_attrib["district_id"] = random_district_ids
          cloned_attrib["province_id"] = kompong_chhnang_id
          cloned_attrib["status"] = random_statuses
        
          cloned = Session.new(cloned_attrib)
        
          cloned.clone_relations if cloned.save

          # feedback sub categories  like, dislike
          if [true, false].sample
            cloned.step_values.clone_step :feedback_like, like_values.sample
          else
            cloned.step_values.clone_step :feedback_dislike, dislike_values.sample
          end

          # overall rating by OWSO
          cloned.step_values.clone_step :feedback_rating, rating_values.sample if [true, false].sample

          print "."

        rescue => e
          puts e.message
        end
    end
  end

  desc 'Migrate session\'s `""` or `nil` gender to `other`'
  task migrate_gender_empty_to_other: :environment do
    ActiveRecord::Base.transaction do
      CSV.open("file.csv", "wb") do |csv|
        csv << ['session_id', 'migrated_at', 'old_gender', 'new_gender', 'old_province_id', 'new_province_id', 'old_district_id', 'new_district_id']

        Session.where(gender: nil).limit(5).find_each do |session|
          session.gender = 'other'
          session.province_id = '00' unless session.province_id?
          session.district_id = '0000' unless session.district_id?

          if true
            csv << body_csv(session) 
          else
            raise "Session #{session.id} cannot be saved due to #{session.errors.messages}"
          end
        end
      end
    end
  end

  def body_csv(session)
    row = [session.id, Date.current.strftime]
    [:gender, :province_id, :district_id].each do |attr|
      row << session.send("#{attr}_was".to_sym)
      row << session.send(attr)
    end
    row
  end
end
