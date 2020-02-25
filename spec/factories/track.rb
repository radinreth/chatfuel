FactoryBot.define do
  factory :track do
    code { FFaker::PhoneNumber.exchange_code }
  end
end
