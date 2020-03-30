# == Schema Information
#
# Table name: messages
#
#  id           :bigint(8)        not null, primary key
#  content_type :string
#  status       :integer(4)       default("0")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  content_id   :integer(4)
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
  default_scope -> { order(updated_at: "desc") }
  delegate :type, :session_id, to: :content

  # validations
  validates :content, presence: true

  # methods
  def self.create_or_return(content)
    message = find_by(content: content)
    message = create(content: content) if !message || message&.completed?
    message
  end
end
