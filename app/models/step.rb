# == Schema Information
#
# Table name: steps
#
#  id         :bigint(8)        not null, primary key
#  act        :string           not null
#  value      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  message_id :bigint(8)        not null
#
# Indexes
#
#  index_steps_on_message_id  (message_id)
#
# Foreign Keys
#
#  fk_rails_...  (message_id => messages.id)
#
class Step < ApplicationRecord
  belongs_to :message
  has_one :track, dependent: :destroy

  validates :act, uniqueness: { scope: :message_id }

  def value
    track.try(:code) || super
  end
end
