FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }

    trait :site_ombudsman do
      role { :site_ombudsman }
    end

    trait :site_admin do
      role { :site_admin }
    end

    trait :system_admin do
      role { :system_admin }
    end
  end
end
