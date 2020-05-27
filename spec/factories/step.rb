FactoryBot.define do
  factory :step do
    association :message, :text

    trait :accessed do
      association :value, factory: :variable_value
    end
  end
end
