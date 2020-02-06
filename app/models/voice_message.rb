class VoiceMessage < ApplicationRecord
  has_one :message, as: :content, dependent: :destroy
  has_many :steps, through: :message
end
