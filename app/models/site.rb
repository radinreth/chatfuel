# == Schema Information
#
# Table name: sites
#
#  id           :bigint(8)        not null, primary key
#  code         :string           default("")
#  name         :string           not null
#  status       :integer(4)       default("0")
#  sync_status  :integer(4)       default("1"), not null
#  token        :string           default("")
#  tracks_count :integer(4)       default("0")
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_sites_on_name  (name)
#
class Site < ApplicationRecord
  attr_accessor :file

  enum status: %i[disable enable]
  enum sync_status: %i[failure success]

  # associations
  has_many :tracks, dependent: :destroy
  has_many :users
  has_many :feedbacks

  # api
  has_many :tickets
  accepts_nested_attributes_for :tickets

  has_one :site_setting, dependent: :destroy

  # validations
  validates :name, presence: true
  validates :sync_status, inclusion: { in: sync_statuses.keys }
  validates :code, uniqueness: true,
                    format: {
                      with: /\A\d{4}\z/,
                      message: I18n.t("site.invalid_code") }

  before_create :generate_token

  def regenerate_token
    generate_token
    self.save
  end

  private
    def generate_token
      begin
        self.token = SecureRandom.hex
      end while self.class.exists?(token: token)
    end
end
