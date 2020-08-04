FactoryBot.define do
  factory :track do
    code { FFaker::PhoneNumber.exchange_code }

    association :site
    association :ticket
  end
end
