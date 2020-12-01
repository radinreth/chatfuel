# == Schema Information
#
# Table name: sessions
#
#  id                  :bigint(8)        not null, primary key
#  gender              :string           default("")
#  last_interaction_at :datetime
#  platform_name       :string           default("")
#  repeated            :boolean          default(FALSE)
#  session_type        :string           default("")
#  status              :integer(4)       default("incomplete")
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  district_id         :string
#  province_id         :string
#  session_id          :string           not null
#  source_id           :string           not null
#
# Indexes
#
#  index_sessions_on_platform_name_and_session_id_and_source_id  (platform_name,session_id,source_id)
#
class Session < ApplicationRecord
  include CsvConcern
  include Session::FilterableConcern

  enum status: %i[incomplete completed]

  PLATFORM_DICT = {
    ivr: :Verboice,
    chatbot: :Messenger
  }

  # TODO: reference session
  has_many :step_values, dependent: :destroy

  default_scope -> { order(updated_at: :desc) }

  validates :platform_name, inclusion: {
                              in: %w(Messenger Telegram Verboice),
                              message: I18n.t("sessions.invalid_platform_name", value: "%{value}") }

  before_update :set_province_id, if: -> { district_id_changed? }
  after_save :update_last_interaction_time
  after_create_commit :completed!, if: :ivr?

  def self.create_or_return(platform_name, session_id)
    session = find_by(platform_name: platform_name, session_id: session_id, source_id: session_id)

    if !session || session&.completed?
      session = create(platform_name: platform_name, session_id: session_id, source_id: session_id)
    else
      session.touch :last_interaction_at
    end

    session
  end

  def mask_session_id
    return md5_session_id if ivr?

    return session_id
  end

  def md5_session_id
    Digest::MD5.hexdigest session_id
  end

  def ivr?
    platform_name == "Verboice"
  end

  def self.accessed(options = {})
    variable = Variable.find_by(is_service_accessed: true)

    scope = filter(options)
    scope.where(step_values: variable.step_values) if variable.present?
  end

  def reachable_period?
    last_interaction_at > Setting.fb_reachable_period.days.ago
  end

  private
    def update_last_interaction_time
      touch :last_interaction_at
    end

    def set_province_id
      self.province_id = district_id[0..1]
    end
end
