# == Schema Information
#
# Table name: roles
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :role do

    trait :site_ombudsman do
      name { "site ombudsman" }
    end

    trait :site_admin do
      name { "site admin" }
    end

    trait :system_admin do
      name { "system admin" }
    end
  end
end
