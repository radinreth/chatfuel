FactoryBot.define do
  factory :message do
    platform_name { 'chatfuel' }

    trait :text do
      association :content, factory: :text_message
    end

    trait :voice do
      association :content, factory: :voice_message
    end
  end
end
