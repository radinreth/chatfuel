class GenderFactory
  MALE = "male"
  FEMALE = "female"
  OTHER = "other"

  GENDER_DICTIONARY = {
    "1" => MALE, "male" => MALE, "m" => MALE,
    "2" => FEMALE, "female" => FEMALE, "f" => FEMALE,
    "3" => OTHER, "not set" => OTHER
  }

  def for(raw)
    "#{ GENDER_DICTIONARY[raw] }Gender".classify.constantize.new
  end
end
