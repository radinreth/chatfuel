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
          if [true, false].sample
            cloned.step_values.clone_step :feedback_rating, rating_values.sample
          end

          print "."
        end
    end
  end

  def rating
    Variable.feedback_rating
  end

  def rating_values
    rating.values.map &:raw_value
  end

  def like
    Variable.feedback_like
  end

  def like_values 
    like.values.map &:raw_value
  end

  def dislike
    Variable.feedback_dislike
  end

  def dislike_values
    dislike.values.map &:raw_value
  end

  def kompong_chhnang_id
    "04"
  end
  
  def random_statuses
    %w(incomplete completed).sample
  end
  
  def random_district_ids
    %w(0401 0402 0403 0404 0405 0406 0407 0408).sample
  end
  
  def random_repeated
    [true, false].sample
  end
  
  def random_gender
    ["male", "female", "other"].sample
  end
  
  def random_channel
    platform_name = %w(IMessenger IVerboice).sample
    platform = platform_name.constantize.new
    platform.random
  end
  
  class IMessenger
    def random
      [platform_name, session_id, source_id]
    end
  
    private
      def platform_name
        "Messenger"
      end
  
      def session_id
        rand(10 ** 16)
      end
  
      def source_id
        session_id
      end
  end
  
  class IVerboice
    def random
      [platform_name, session_id, source_id]
    end
  
    private
      def platform_name
        "Verboice"
      end
  
      def session_id
        FFaker::PhoneNumber.phone_number
      end
      
      def source_id
        rand(10 ** 6)
      end
  end

end
