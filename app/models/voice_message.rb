class VoiceMessage < ApplicationRecord
  has_one :message, as: :content, dependent: :destroy
  has_many :steps, through: :message

  alias_attribute :session_id, :CallSid

  def type
    'IVR'
  end
end
