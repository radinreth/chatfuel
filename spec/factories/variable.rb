FactoryBot.define do
  factory :variable do
    name { FFaker::Name.unique.first_name }
  end
end
