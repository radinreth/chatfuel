FactoryBot.define do
  factory :site do
    name { FFaker::Name::first_name }
    code { FFaker::Code::ean[0...4] }
  end
end
