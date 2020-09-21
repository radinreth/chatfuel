FactoryBot.define do
  factory :variable do
    name { FFaker::Name.unique.first_name }
  end

  trait :ticket_tracking do
    is_ticket_tracking { true }
  end
end
