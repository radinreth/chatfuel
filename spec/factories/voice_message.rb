FactoryBot.define do
  factory :voice_message do
    CallSid { FFaker::IdentificationBR.rg }
    address { FFaker::PhoneNumber.short_phone_number }
  end
end
