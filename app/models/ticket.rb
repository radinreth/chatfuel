# == Schema Information
#
# Table name: tickets
#
#  id                  :bigint           not null, primary key
#  code                :string           not null
#  status              :integer          default("0")
#  submitted_at        :date
#  completed_at        :date
#  actual_completed_at :date
#  picked_up_at        :date
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Ticket < ApplicationRecord
  enum status: %i[submitted completed notified picked_up]

  validates :status, inclusion: { in: statuses.keys }
end
