namespace :tracking do
  desc "migrate attribute message to session"
  task migrate_message_to_session: :environment do
    unless Tracking.column_names.include? 'message_id'
      puts "message attribute is undefined or no longer exist, Nothing to migrate!"
      exit
    end

    ActiveRecord::Base.record_timestamps = false
    
    ActiveRecord::Base.transaction do
      Tracking.find_each do |tracking|
        print "."
        tracking.session_id = tracking.message_id
        tracking.save
      end
    end

    ActiveRecord::Base.record_timestamps = true
  end

  desc "Reverse migration attribute message to session"
  task reverse_migrate_message_to_session: :environment do
    unless Tracking.column_names.include? 'message_id'
      puts "message attribute is undefined or no longer exist, Nothing to migrate!"
      exit
    end

    ActiveRecord::Base.record_timestamps = false
    
    ActiveRecord::Base.transaction do
      Tracking.find_each do |tracking|
        print "."
        tracking.message_id = tracking.session_id
        tracking.save
      end
    end

    ActiveRecord::Base.record_timestamps = true
  end

end
