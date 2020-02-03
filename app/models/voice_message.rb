class VoiceMessage < ApplicationRecord
  has_one :message, as: :content, dependent: :destroy
  has_many :voice_answers
end
