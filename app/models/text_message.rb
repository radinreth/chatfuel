# == Schema Information
#
# Table name: text_messages
#
#  id                :bigint(8)        not null, primary key
#  first_name        :string
#  gender            :string
#  last_name         :string
#  profile_pic_url   :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  messenger_user_id :string           not null
#
class TextMessage < ApplicationRecord
  has_one :message, as: :content, dependent: :destroy

  alias_attribute :session_id, :messenger_user_id

  def type
    "Chatbot"
  end
end
