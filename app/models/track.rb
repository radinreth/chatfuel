# == Schema Information
#
# Table name: tracks
#
#  id         :bigint(8)        not null, primary key
#  code       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  site_id    :bigint(8)
#  step_id    :bigint(8)
#  ticket_id  :bigint(8)
#
# Indexes
#
#  index_tracks_on_site_id    (site_id)
#  index_tracks_on_step_id    (step_id)
#  index_tracks_on_ticket_id  (ticket_id)
#
class Track < ApplicationRecord
  # associations
  belongs_to :site, counter_cache: true, optional: true
  belongs_to :step, optional: true
  belongs_to :ticket, optional: true

  validates :code, presence: true

  def site_code
    code[0...4]
  end
end
