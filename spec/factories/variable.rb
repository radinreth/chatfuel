FactoryBot.define do
  factory :variable do
    name { FFaker::Name.name }
  end
end
