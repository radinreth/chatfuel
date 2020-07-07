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
#  whitelist    :text
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
  validates :token, presence: true, if: :persisted?
  validates :whitelist, presence: true, if: :persisted?
  validate :whitelist_format

  before_validation :generate_whitelist, on: :create
  before_create :generate_token

  def self.find_with_whitelist(token, ip)
    where(token: token, whitelist: '*').or(where('token = ? AND whitelist LIKE ?', token, "%#{ip}%")).first
  end

  private
    def whitelist_format
      return true if whitelist == '*'

      valid = true
      whitelist.to_s.split(';').each do |ip|
        valid = !(IPAddr.new(ip.strip) rescue nil).nil?
        return errors.add(:whitelist, I18n.t("site.invalid_whitelist")) unless valid
      end

      valid
    end

    def generate_token
      begin
        self.token = SecureRandom.hex
      end while self.class.exists?(token: token)
    end

    def generate_whitelist
      self.whitelist ||= '*'
    end
end
