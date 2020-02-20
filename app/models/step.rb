class Step < ApplicationRecord
  belongs_to :message
  has_one :track

  validates :act, uniqueness: { scope: :message_id }
end
