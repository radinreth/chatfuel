FactoryBot.define do
  factory :site do
    name { FFaker::Name::first_name }
    code { FFaker::Code::ean }
  end
end
