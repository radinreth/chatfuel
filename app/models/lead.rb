class Lead < ApplicationRecord
  has_many :activities, dependent: :destroy

  def list
    activities.pluck(:name, :value).to_h.inspect
  end

  def progress
    activities.where(value: 'DONE').present?
  end
end
