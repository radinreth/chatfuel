# == Schema Information
#
# Table name: templates
#
#  id         :bigint(8)        not null, primary key
#  content    :string           default("")
#  status     :string           default("0")
#  type       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :template do
    content { "My template" }
    type { "MessengerTemplate" }

    trait :incomplete do
      status { :incomplete }
      content { "your ticket is incomplete" }
    end
  end
end
