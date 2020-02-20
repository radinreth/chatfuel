FactoryBot.define do
  factory :step do
    act { FFaker::Name::suffix }
  end
end
