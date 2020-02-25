# == Schema Information
#
# Table name: tickets
#
#  id                  :bigint(8)        not null, primary key
#  actual_completed_at :date
#  code                :string           not null
#  completed_at        :date
#  picked_up_at        :date
#  status              :integer(4)       default("0")
#  submitted_at        :date
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
# Indexes
#
#  index_tickets_on_code  (code)
#
class Ticket < ApplicationRecord
  enum status: %i[submitted completed notified picked_up]

  validates :status, inclusion: { in: statuses.keys }
end
