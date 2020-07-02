FactoryBot.define do
  factory :ticket do
    code { FFaker::PhoneNumber.area_code }

    association :step
    association :site
    
    trait :completed do
      status { :completed }
    end
  end
end
