# == Schema Information
#
# Table name: tickets
#
#  id                  :bigint(8)        not null, primary key
#  actual_completed_at :date
#  approval_date       :datetime
#  code                :string           not null
#  completed_at        :date
#  delivery_date       :datetime
#  dist_gis            :string
#  incomplete_at       :date
#  incorrect_at        :date
#  requested_date      :datetime
#  service_description :string
#  status              :string
#  tell                :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  site_id             :bigint(8)
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
  # enum status: %i[incomplete completed incorrect notified]

  STATUSES = %w(accepted paid approved rejected delivered)

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
  validates :status, inclusion: { in: STATUSES }

  delegate :platform_name, to: :message, allow_nil: true

  before_validation :set_status

  def self.filter(params = {})
    scope = all
    scope = scope.where('code LIKE ?', "%#{params[:keyword].downcase}%") if params[:keyword].present?
    scope
  end

  private
    def set_status
      self.status = status.try(:downcase) || STATUSES[0]
    end
end
