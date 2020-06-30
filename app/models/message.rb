# == Schema Information
#
# Table name: messages
#
#  id                  :bigint(8)        not null, primary key
#  content_type        :string
#  last_interaction_at :datetime         default("2020-06-30 04:09:55.715753")
#  platform_name       :string           default("")
#  status              :integer(4)       default("0")
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  content_id          :integer(4)
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
  delegate :type, :session_id, to: :content

  # validations
  validates :content, presence: true
  validates :platform_name, inclusion: {  in: %w(Messenger Telegram Verboice),
                                          message: "%{value} is not a valid platform name" }

  # methods
  def self.create_or_return(platform_name, content)
    message = find_by(content: content)
    message = create(platform_name: platform_name, content: content) if !message || message&.completed?
    message.touch :last_interaction_at
    message
  end

  def self.complete_all
    all.map(&:completed!)
  end
end
