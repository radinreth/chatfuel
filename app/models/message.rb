# == Schema Information
#
# Table name: messages
#
#  id                  :bigint(8)        not null, primary key
#  content_type        :string
#  gender              :string           default("")
#  last_interaction_at :datetime         default(Mon, 03 Aug 2020 10:01:25 +07 +07:00)
#  platform_name       :string           default("")
#  repeated            :boolean          default(FALSE)
#  status              :integer(4)       default("incomplete")
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  content_id          :integer(4)
#  district_id         :string(8)
#  province_id         :string
#
# Indexes
#
#  index_messages_on_content_type_and_content_id  (content_type,content_id)
#
class Message < ApplicationRecord
  include CsvConcern

  enum status: %i[incomplete completed]

  # associations
  belongs_to :content, polymorphic: true, dependent: :destroy
  has_many :step_values, dependent: :destroy
  has_many :trackings, dependent: :destroy

  # scopes
  default_scope -> { order(updated_at: :desc) }

  delegate :type, :session_id, to: :content

  # validations
  validates :content, presence: true
  validates :platform_name, inclusion: {  in: %w(Messenger Telegram Verboice),
                                          message: "%{value} is not a valid platform name" }

  # Callback
  before_update :set_province_id, if: -> { district_id_changed? }

  # methods
  def self.create_or_return(platform_name, content)
    message = find_by(content: content)

    message.touch(:last_interaction_at) and return(message) if message && message.incomplete?

    create! do |m|
      m.platform_name = platform_name
      m.content = content
      m.gender = message&.gender
      m.repeated = message&.completed?
      m.province_id = message&.province_id
      m.district_id = message&.district_id
    end
  end

  def self.accessed(options = {})
    variable = Variable.service_accessed

    scope = filter(options)
    scope.where(step_values: variable.step_values) if variable.present?
  end

  def reachable_period?
    last_interaction_at > ENV["FB_REACHABLE_IN_DAY"].to_i.days.ago
  end

  def self.complete_all
    all.map(&:completed!)
  end

  def self.filter(params = {})
    scope = all
    scope = scope.where(gender: params[:gender]) if params[:gender].present?
    scope = scope.where(content_type: params[:content_type]) if params[:content_type].present?
    scope = scope.where(province_id: params[:province_id]) if params[:province_id].present?
    scope = scope.where(district_id: params[:district_id]) if params[:district_id].present?
    scope = scope.where(platform_name: params[:platform]) if params[:platform].present?
    scope = scope.where("DATE(created_at) BETWEEN ? AND ?", params[:start_date], params[:end_date]) if params[:start_date].present? && params[:end_date].present?
    scope
  end

  def last_completed
    @last_completed ||= Message.completed.where(content_type: "TextMessage", content_id: content_id)\
                                .where("last_interaction_at < ?", created_at)\
                                .find_by("province_id IS NOT NULL AND district_id IS NOT NULL AND gender != ''")
  end

  private
    def set_province_id
      self.province_id = district_id[0..1]
    end
end
