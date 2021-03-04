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
