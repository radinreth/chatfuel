class VoiceMessage < ApplicationRecord
  has_one :message, as: :content, dependent: :destroy
end
