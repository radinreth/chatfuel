FactoryBot.define do
  factory :voice_message do
    callsid { FFaker::IdentificationBR.rg }
    address { FFaker::PhoneNumber.short_phone_number }
  end
end
