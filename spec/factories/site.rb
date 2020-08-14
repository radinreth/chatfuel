FactoryBot.define do
  factory :site do
    name_en { FFaker::Name.first_name }
    code { FFaker::Code.ean[0...4] }
  end
end
