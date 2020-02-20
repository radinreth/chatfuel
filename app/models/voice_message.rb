class VoiceMessage < ApplicationRecord
  has_one :message, as: :content, dependent: :destroy
  has_many :steps, through: :message

  alias_attribute :session_id, :callsid

  def type
    'IVR'
  end
end
