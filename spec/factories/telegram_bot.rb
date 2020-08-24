# == Schema Information
#
# Table name: telegram_bots
#
#  id         :bigint(8)        not null, primary key
#  actived    :boolean          default("false")
#  token      :string
#  username   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :telegram_bot do
    actived   { true }
    token     {'123:xyz'}
    username  {'bot'}

    after(:build) { |telegram_bot|
      class << telegram_bot
        def post_webhook_to_telegram; true; end
      end
    }
  end
end
