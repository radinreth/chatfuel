class Message < ApplicationRecord
  has_many :steps, dependent: :destroy
  belongs_to :content, polymorphic: true, dependent: :destroy

  default_scope -> { order(updated_at: 'desc') }
  delegate :type, :session_id, to: :content

  def completed?
    steps.where(act: 'done', value: 'true').present?
  end

  def self.create_or_update(content)
    message = find_by(content: content)
    message = create(content: content) if !message || message.completed?
    message
  end

  def last_step
    steps.last
  end
end
