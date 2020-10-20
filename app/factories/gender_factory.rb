class GenderFactory
  GENDER_DICTIONARY = {
    "1" => "male", "male" => "male", "m" => "male",
    "2" => "female", "female" => "female", "f" => "female",
    "3" => "other", "not set" => "other"
  }

  def for(raw)
    "#{ GENDER_DICTIONARY[raw] }Gender".classify.constantize.new
  end
end
