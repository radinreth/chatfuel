# == Schema Information
#
# Table name: quota
#
#  id                 :bigint(8)        not null, primary key
#  on_reach_threshold :string           default("delay")
#  platform_name      :string           default("messenger")
#  secure_zone        :float            default(0.75)
#  threshold          :integer(4)       default(0)
#  total_sent         :integer(4)       default(0)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
class Quotum < ApplicationRecord
  validate :ensure_threshold_gte_total_sent
  validates :on_reach_threshold, inclusion: { in: %w(delay drop) }

  def remain_size
    threshold - total_sent
  end

  def sentable_size(max = 1000)
    remain_size > max ? max : remain_size
  end

  def drop?
    on_reach_threshold == "drop"
  end

  private
    def ensure_threshold_gte_total_sent
      errors.add(:total_sent, "Cannot sent ticket more than threshold") if total_sent > threshold
    end
end
