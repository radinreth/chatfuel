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
  enum status: %i[disable enable]

  has_many :tracks, dependent: :destroy
  has_many :users
  has_many :feedbacks

  validates :name, presence: true
  validates :code, uniqueness: true, 
                    format: { 
                      with: /\A\d{4}\z/, 
                      message: "site code must be exactly 4 digits number" }
end
