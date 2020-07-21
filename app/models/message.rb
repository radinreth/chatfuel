# == Schema Information
#
# Table name: messages
#
#  id                  :bigint(8)        not null, primary key
#  content_type        :string
#  last_interaction_at :datetime         default("2020-07-03 03:23:38.104596")
#  platform_name       :string           default("")
#  status              :integer(4)       default("0")
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  content_id          :integer(4)
#  province_id         :string
#
# Indexes
#
#  index_messages_on_content_type_and_content_id  (content_type,content_id)
#
class Message < ApplicationRecord
  enum status: %i[incomplete completed]

  # associations
  has_many :steps, dependent: :destroy, autosave: true
  belongs_to :content, polymorphic: true, dependent: :destroy

  # scopes
  default_scope -> { order(updated_at: :desc) }
  scope :load_by_role, -> (role) {  joins(steps: { value: :variable })\
                                    .where("variables.name IN (?)", role.variable_names) }
  delegate :type, :session_id, to: :content

  # validations
  validates :content, presence: true
  validates :platform_name, inclusion: {  in: %w(Messenger Telegram Verboice),
                                          message: "%{value} is not a valid platform name" }

  # methods
  def self.create_or_return(platform_name, content)
    message = find_by(content: content)

    if !message || message&.completed?
      message = create(platform_name: platform_name, content: content)
    else
      message.touch :last_interaction_at
    end

    message
  end

  def self.complete_all
    all.map(&:completed!)
  end

  def self.user_count(params = {})
    scope = all
    scope = scope.joins(:steps)
    scope = scope.where(content_type: params[:content_type]) if params[:content_type].present?
    scope = scope.where(province_id: params[:province_id]) if params[:province_id].present?
    scope = scope.where(platform_name: params[:platform_name]) if params[:platform_name].present?
    scope = scope.where("DATE(messages.created_at) BETWEEN ? AND ?", params[:start_date], params[:end_date]) if params[:start_date].present? && params[:end_date].present?
    scope.count
  end
end
