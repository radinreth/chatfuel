# == Schema Information
#
# Table name: tickets
#
#  id                  :bigint(8)        not null, primary key
#  actual_completed_at :date
#  code                :string           not null
#  completed_at        :date
#  incomplete_at       :date
#  incorrect_at        :date
#  status              :integer(4)       default("0")
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  site_id             :bigint(8)
#
# Indexes
#
#  index_tickets_on_code  (code)
#
class Ticket < ApplicationRecord
  enum status: %i[incomplete completed incorrect notified]

  # associations
  has_one :track, dependent: :destroy
  has_one :step, through: :track
  has_one :message, through: :step
  belongs_to :site

  # scopes
  scope :completed_with_session, -> { completed.joins(:message).distinct }
  scope :completed_in_time_range, -> { completed_with_session.where("DATE(messages.last_interaction_at) > DATE(?)", ENV["FB_MESSAGE_QUOTA_IN_DAY"].to_i.days.ago) }

  # validations
  validates :code, presence: true
  validates :status, inclusion: { in: statuses.keys }

  delegate :platform_name, to: :message, allow_nil: true
end
