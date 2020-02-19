class Message < ApplicationRecord
  has_many :steps, dependent: :destroy
  belongs_to :content, polymorphic: true, dependent: :destroy

  default_scope -> { order(updated_at: 'desc') }
  delegate :type, :session_id, to: :content

  # validations
  validates :content, presence: true

  def self.create_or_return(content)
    message = find_by(content: content)
    message = create(content: content) if !message || message.completed?
    message
  end

  def completed?
    steps.where(act: 'done', value: 'true').present?
  end
end
