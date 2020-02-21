FactoryBot.define do
  factory :ticket do
    code { FFaker::PhoneNumber.area_code }
  end
end
