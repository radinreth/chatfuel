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
#  site_id             :bigint(8)        not null
#
# Indexes
#
#  index_tickets_on_code     (code)
#  index_tickets_on_site_id  (site_id)
#
# Foreign Keys
#
#  fk_rails_...  (site_id => sites.id)
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


# completed => approved_at
# incomplete_at => submitted/accepted_at
# picked_up_at => delivered_at

# tickets: [
#   {
#     id: "836E4FE2-0710-41B0-8045-D65EC06356A7",
#     serviceDescription:  "សេចក្តីចម្លងសំបុត្រកំណើត ឬសំបុត្របញ្ជាក់កំណើត",
#     createdAt: "7/1/2020 11:19:05 AM",
#     requestedDate: "7/1/2020 11:18:11 AM",
#     Tel: "010 993 333",
#     VillGis: "12140207",
#     Name: "ញឹក បុរិន្ទ",
#     Status: "30",
#     ApprovedDate: "10/16/2019",
#     DeliveryDate: "10/16/2019"
#   }
# ]
