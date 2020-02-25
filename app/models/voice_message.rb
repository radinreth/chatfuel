# == Schema Information
#
# Table name: voice_messages
#
#  id          :bigint           not null, primary key
#  callsid     :integer
#  address     :string
#  called_at   :datetime
#  finished_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :integer
#
class VoiceMessage < ApplicationRecord
  has_one :message, as: :content, dependent: :destroy
  has_many :steps, through: :message

  alias_attribute :session_id, :callsid

  def type
    'IVR'
  end
end
