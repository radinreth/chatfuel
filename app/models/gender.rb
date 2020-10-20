class Gender
  MALE = :male
  FEMALE = :female
  OTHER = :other

  GENDER_DICTIONARY = {
    "1" => MALE, "male" => MALE, "m" => MALE,
    "2" => FEMALE, "female" => FEMALE, "f" => FEMALE,
    "3" => OTHER, "not set" => OTHER
  }

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.get(name)
    "Genders::#{GENDER_DICTIONARY[name].to_s.camelize}Gender".classify.constantize.new
  end
end
