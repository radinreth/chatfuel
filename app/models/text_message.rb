class TextMessage < ApplicationRecord

  has_one :message, as: :content, dependent: :destroy
  has_many :steps, through: :message

  delegate :f1, :f11, :f111, to: :steps
  delegate :f112, :f113, :f12, to: :steps
  delegate :f121, :f122, :f13, :f131, to: :steps
  
  alias_attribute :session_id, :messenger_user_id
end
