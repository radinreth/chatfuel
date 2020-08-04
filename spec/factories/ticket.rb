FactoryBot.define do
  factory :ticket do
    code { FFaker::PhoneNumber.area_code }
    site

    trait :accepted do
      status { :accepted }
    end

    trait :completed do
      status { 'approved' }
    end

    trait :incomplete do
      status { "accepted" }
    end

    trait :incomplete do
      status { "accepted" }
    end
  end
end
