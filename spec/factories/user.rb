FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }

    trait :ombudsman do
      role { :ombudsman }
    end

    trait :site_admin do
      role { :site_admin }
    end

    trait :system_admin do
      role { :system_admin }
    end
  end
end
