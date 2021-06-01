# == Schema Information
#
# Table name: templates
#
#  id         :bigint(8)        not null, primary key
#  content    :string           default("")
#  status     :string           default("incomplete")
#  type       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :template do
    content { "My template" }
    type { "MessengerTemplate" }

    trait :telegram do
      type { "TelegramTemplate" }
    end

    trait :incomplete do
      status { :incomplete }
      content { "your ticket is incomplete" }
    end

    trait :completed do
      status { :completed }
      content { "your ticket is completed" }
    end

    trait :incorrect do
      status { :incorrect }
      content { "your ticket is incorrect" }
    end

    [:messenger, :telegram].each do |platform|
      trait platform do
        incomplete
        type { "#{platform.to_s.capitalize}Template" }
      end
    end

    trait :verboice do
      incomplete
      type { "VerboiceTemplate" }

      after(:build) do |t|
        t.audio.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'files', 'incompleted_audio.mp3')), filename: 'incompleted_audio.mp3')
      end
    end
  end
end
