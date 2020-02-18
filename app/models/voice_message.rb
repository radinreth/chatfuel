class VoiceMessage < ApplicationRecord
  has_one :message, as: :content, dependent: :destroy
  has_many :steps, through: :message

  delegate :f111, to: :steps
  delegate :f112, :f113, :f12, to: :steps
  delegate :f121, :f122, :f13, :f131, to: :steps

  alias_attribute :session_id, :CallSid

  def type
    'IVR'
  end

  def services
    {
      'f1': { '1': 'owso info', '2': 'feedback', '3': 'tracking' },
      'f11': { '1': 'birth', '2': 'business', '3': 'land' }
    }
  end

  def f1
    answer('f1', steps.f1.value)
  end

  def f11
    answer('f11', steps.f11.value)
  end

  private

  def answer(type, value)
    OpenStruct.new(value: services[type.to_sym][value.to_sym])
  end
end
