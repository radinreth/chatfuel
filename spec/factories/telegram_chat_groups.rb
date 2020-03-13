# == Schema Information
#
# Table name: telegram_chat_groups
#
#  id         :bigint(8)        not null, primary key
#  is_active  :boolean
#  reason     :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  chat_id    :integer(4)
#
FactoryBot.define do
  factory :telegram_chat_group do
    title { "MyString" }
    chat_id { 1 }
    is_active { false }
    reason { "MyText" }
  end
end
