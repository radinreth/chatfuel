class Track < ApplicationRecord
  belongs_to :site, counter_cache: true, optional: true
  belongs_to :step, optional: true

  validates :code, presence: true

  def site_code
    code[0...4]
  end
end
