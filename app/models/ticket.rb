class Ticket < ApplicationRecord
  enum status: %i[submitted completed picked_up]

  validates :status, inclusion: { in: statuses.keys }
end
