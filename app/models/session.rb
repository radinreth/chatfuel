# == Schema Information
#
# Table name: sessions
#
#  id                  :bigint(8)        not null, primary key
#  last_interaction_at :datetime
#  platform_name       :string           default("")
#  status              :integer(4)       default("0")
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  district_id         :string
#  province_id         :string
#  session_id          :string           not null
#
class Session < ApplicationRecord
  include CsvConcern

  enum status: %i[incomplete completed]

  # TODO: reference session
  has_many :step_values, dependent: :destroy

  default_scope -> { order(updated_at: :desc) }
  scope :period, -> (start_date, end_date) { where("DATE(last_interaction_at) BETWEEN ? AND ?", start_date, end_date) }

  validates :platform_name, inclusion: {
                              in: %w(Messenger Telegram Verboice),
                              message: I18n.t("sessions.invalid_platform_name", value: "%{value}") }

  before_update :set_province_id, if: -> { district_id_changed? }

  def self.create_or_return(platform_name, session_id)
    session = find_by(session_id: session_id)

    if !session || session&.completed?
      session = create(platform_name: platform_name, session_id: session_id)
    else
      session.touch :last_interaction_at
    end

    session
  end

  def self.accessed(options = {})
    variable = Variable.find_by(is_service_accessed: true)

    scope = all
    scope = filter(scope, options)
    scope.where(step_values: variable.step_values) if variable.present?
  end

  def reachable_period?
    last_interaction_at > ENV["FB_REACHABLE_IN_DAY"].to_i.days.ago
  end

  def self.user_count(params = {})
    scope = all
    scope = filter(scope, params)
    scope
  end

  def self.filter(scope, params={})
    scope = scope.where(content_type: params[:content_type]) if params[:content_type].present?
    scope = scope.where(province_id: params[:province_id]) if params[:province_id].present?
    scope = scope.where(district_id: params[:district_id]) if params[:district_id].present?
    scope = scope.where(platform_name: params[:platform_name]) if params[:platform_name].present?
    scope = scope.where("DATE(created_at) BETWEEN ? AND ?", params[:start_date], params[:end_date]) if params[:start_date].present? && params[:end_date].present?
    scope
  end

  private
    def set_province_id
      self.province_id = district_id[0..1]
    end
end
