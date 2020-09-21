FactoryBot.define do
  factory :variable do
    name { FFaker::Name.unique.first_name }

    trait :feedback_location do
      marks_as { ['feedback_location'] }
    end
  end
end
