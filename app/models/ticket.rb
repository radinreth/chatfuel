class Ticket < ApplicationRecord
  enum status: [:submitted, :completed, :picked_up]
end
