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
  has_many :trackings, dependent: :destroy

  default_scope -> { order(updated_at: :desc) }

  validates :platform_name, inclusion: {
                              in: %w(Messenger Telegram Verboice),
                              message: I18n.t("sessions.invalid_platform_name", value: "%{value}") }

  before_update :set_province_id, if: -> { district_id_changed? }
  after_save :update_last_interaction_time
  after_create_commit :completed!, if: :ivr?

  def self.create_or_return(platform_name, session_id)
    session = find_or_initialize_by(platform_name: platform_name, session_id: session_id, source_id: session_id)

    return session.clone if session.completed?

    session.last_interaction_at = Time.now
    session.save!
    session
  end

  def clone
    prev = last_completed_before(Time.now)
    return self unless prev.present?

    attrs = prev.attributes.slice(*clone_attributes)
    session = Session.create!(attrs.merge({ repeated: true }))
    session.clone_relations
  end

  def clone_relations
    step_values.clone_step :gender, gender
    step_values.clone_step :location, district_id
    self
  end

  def last_completed(time = created_at)
    Session.completed.where(platform_name: platform_name, session_id: session_id)\
                      .where("last_interaction_at <= ?", time)\
                      .find_by("province_id IS NOT NULL AND district_id IS NOT NULL AND gender != ''")
  end
  alias_method :last_completed_before, :last_completed

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

  def self.user_count(params = {})
    scope = all
    scope = filter(scope, params)
    scope
  end

  private
    def update_last_interaction_time
      touch :last_interaction_at
    end

    def set_province_id
      self.province_id = district_id[0..1]
    end

    def clone_attributes
      %w(platform_name session_id source_id gender province_id district_id)
    end
end
