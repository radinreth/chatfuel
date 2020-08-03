FactoryBot.define do
  factory :ticket do
    code { FFaker::PhoneNumber.area_code }

    association :site

    trait :completed do
      status { :completed }
    end
  end
end
