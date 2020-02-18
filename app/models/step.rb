class Step < ApplicationRecord
  belongs_to :message

  validates :act, uniqueness: { scope: :message_id }
end
