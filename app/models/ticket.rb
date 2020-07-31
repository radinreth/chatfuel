# == Schema Information
#
# Table name: tickets
#
#  id                  :bigint(8)        not null, primary key
#  actual_completed_at :date
#  approved_date       :datetime
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
  STATUSES = %w(accepted paid approved rejected delivered)

  belongs_to :site

  scope :completed_with_session, -> { completed.joins(:message).distinct }
  scope :completed_in_time_range, -> { completed_with_session.where("DATE(messages.last_interaction_at) > DATE(?)", ENV["FB_MESSAGE_QUOTA_IN_DAY"].to_i.days.ago) }
  scope :accepted,  -> { where(status: 'accepted') }
  scope :delivered, -> { where(status: 'delivered') }
  scope :completed, -> { where(status: ['approved', 'delivered']) }

  validates :code, presence: true
  validates :status, inclusion: { in: STATUSES }
  before_validation :set_status

  delegate :platform_name, to: :message, allow_nil: true

  def progress_status
    return 'incomplete' if %w(accepted paid).include?(status)

    'completed'
  end

  def self.filter(params = {})
    scope = all
    scope = scope.where("LEFT(site_id, 2) = ?", params[:province_id]) if params[:province_id].present?
    scope = scope.where('code LIKE ?', "%#{params[:keyword].downcase}%") if params[:keyword].present?
    scope = scope.where("DATE(requested_date) BETWEEN ? AND ?", params[:start_date], params[:end_date]) if params[:start_date].present? && params[:end_date].present?
    scope
  end

  private
    def set_status
      self.status = status.try(:downcase) || STATUSES[0]
    end
end
