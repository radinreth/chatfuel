class Message < ApplicationRecord
  has_many :steps
  belongs_to :content, polymorphic: true

  def last_step
    steps.last
  end
end
