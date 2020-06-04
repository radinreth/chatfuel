FactoryBot.define do
  factory :track do
    code { FFaker::PhoneNumber.exchange_code }

    association :site
    association :step
    association :ticket
  end
end
