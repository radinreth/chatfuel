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

  namespace :migrate_empty_gender_and_location_to_other do
    csv_file = Rails.root.join('db', 'datasources', "empty_gender_location_#{Time.current.to_formatted_s(:number)}.csv")

    desc 'Migrate session\'s `""` or `nil` gender to `other`, `00` for province_id, `0000` for district_id'
    task up: :environment do
      ActiveRecord::Base.transaction do
        CSV.open(csv_file, "wb") do |csv|
          csv << header_csv

          Session.where(gender: nil).find_each do |session|
            session.gender = 'other'
            session.province_id = '00' unless session.province_id?
            session.district_id = '0000' unless session.district_id?
            row = body_csv(session)

            if session.save
              csv << row
            else
              raise "Session #{session.id} cannot be saved due to #{session.errors.messages}"
            end
          end
        end

      rescue => exception
        puts exception.message
      end
    end

    desc 'Rollback session empty gender, location to old state'
    task down: :environment do
      ActiveRecord::Base.transaction do
        CSV.foreach(csv_file, headers: true, encoding: "bom|utf-8").each do |row|
          session = Session.find(row["session_id"])

          if session.present?
            session.update_columns(
              gender: row["old_gender"],
              province_id: row["old_province_id"],
              district_id: row["old_district_id"] )
          end
        end
      rescue => e
        puts e.message
      end
    end
  end
  
  def header_csv
    %w(session_id migrated_at old_gender new_gender 
      old_province_id new_province_id old_district_id new_district_id)
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
