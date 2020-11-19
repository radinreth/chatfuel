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
        print "."
        session = Session.find_by(session_id: message.session_id)
        session.gender = message.gender
        session.save
      end
    end

    ActiveRecord::Base.record_timestamps = true
  end

end
