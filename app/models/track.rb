# == Schema Information
#
# Table name: tracks
#
#  id         :bigint           not null, primary key
#  code       :string
#  site_id    :bigint
#  step_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Track < ApplicationRecord
  belongs_to :site, counter_cache: true, optional: true
  belongs_to :step, optional: true

  validates :code, presence: true

  def site_code
    code[0...4]
  end
end
