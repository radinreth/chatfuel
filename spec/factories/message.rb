FactoryBot.define do
  factory :message do
    platform_name { "Messenger" }
    content { create(:text_message) }

    trait :text do
      association :content, factory: :text_message
    end

    trait :voice do
      association :content, factory: :voice_message
    end
  end
end
