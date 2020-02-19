FactoryBot.define do
  factory :text_message do
    messenger_user_id { FFaker::PhoneNumber.imei }
  end
end
