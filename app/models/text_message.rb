class TextMessage < ApplicationRecord
  has_one :message, as: :content, dependent: :destroy
  has_many :steps, through: :message

  alias_attribute :session_id, :messenger_user_id

  def type
    'Chatbot'
  end
end
