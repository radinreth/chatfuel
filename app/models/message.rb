class Message < ApplicationRecord
  has_many :steps, dependent: :destroy
  belongs_to :content, polymorphic: true, dependent: :destroy

  def last_step
    steps.last
  end
end
