# == Schema Information
#
# Table name: text_messages
#
#  id                       :bigint(8)        not null, primary key
#  first_name               :string
#  gender                   :string
#  last_clicked_button_name :string
#  last_name                :string
#  last_seen                :string
#  last_visited_block_name  :string
#  locale                   :string
#  profile_pic_url          :string
#  sessions                 :string
#  signed_up                :string
#  source                   :string
#  timezone                 :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  last_visited_block_id    :string
#  messenger_user_id        :bigint(8)
#
class TextMessage < ApplicationRecord
  has_one :message, as: :content, dependent: :destroy
  has_many :steps, through: :message

  alias_attribute :session_id, :messenger_user_id

  def type
    'Chatbot'
  end
end
