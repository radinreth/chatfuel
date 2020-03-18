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
class TelegramChatGroup < ApplicationRecord
  scope :actives, -> { where(is_active: true) }
end
