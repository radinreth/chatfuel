class Message < ApplicationRecord
  has_many :steps, dependent: :destroy
  belongs_to :content, polymorphic: true

  def last_step
    steps.last
  end
end
