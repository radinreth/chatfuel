# == Schema Information
#
# Table name: sites
#
#  id           :bigint(8)        not null, primary key
#  code         :string           default("")
#  name         :string           not null
#  status       :integer(4)       default("0")
#  tracks_count :integer(4)       default("0")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_sites_on_name  (name)
#
class Site < ApplicationRecord
  enum status: %i[enable disable]

  has_many :tracks, dependent: :destroy
  has_many :users

  validates :code, uniqueness: true
end
