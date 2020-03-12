# == Schema Information
#
# Table name: telegram_bots
#
#  id         :bigint(8)        not null, primary key
#  token      :string
#  username   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :telegram_bot do
    username { "MyString" }
    token { "MyString" }
  end
end
