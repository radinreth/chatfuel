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

    trait :completed do
      status { 'completed' }
    end

    trait :basic_info do
      province_id { 11 }
      district_id { 1111 }
      gender { "male" }
    end
  end
end
