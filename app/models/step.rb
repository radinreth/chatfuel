# == Schema Information
#
# Table name: steps
#
#  id         :bigint           not null, primary key
#  act        :string           not null
#  value      :string
#  message_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Step < ApplicationRecord
  belongs_to :message
  has_one :track, dependent: :destroy

  validates :act, uniqueness: { scope: :message_id }

  def value
    track.try(:code) || super
  end
end
