# == Schema Information
#
# Table name: voice_messages
#
#  id          :bigint(8)        not null, primary key
#  address     :string
#  called_at   :datetime
#  callsid     :integer(4)
#  finished_at :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  project_id  :integer(4)
#
class VoiceMessage < ApplicationRecord
  # associations
  has_one :message, as: :content, dependent: :destroy

  alias_attribute :session_id, :callsid

  def type
    "IVR"
  end
end
