# == Schema Information
#
# Table name: sites
#
#  id           :bigint(8)        not null, primary key
#  code         :string           default("")
#  lat          :string           default("")
#  lng          :string           default("")
#  name         :string           not null
#  status       :integer(4)       default("0")
#  sync_status  :integer(4)
#  token        :string           default("")
#  tracks_count :integer(4)       default("0")
#  whitelist    :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  province_id  :string
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
  has_many :sync_logs

  # api
  has_many :tickets
  accepts_nested_attributes_for :tickets

  has_one :site_setting, dependent: :destroy

  # validations
  validates :name, presence: true
  validates :sync_status, inclusion: { in: sync_statuses.keys }, allow_nil: true
  validates :code, uniqueness: true,
                    format: {
                      with: /\A\d{4}\z/,
                      message: I18n.t("site.invalid_code") }
  validates :token, presence: true, if: :persisted?
  validates :whitelist, presence: true, if: :persisted?
  validates :lat, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }, allow_blank: true
  validates :lng, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }, allow_blank: true
  validate :whitelist_format

  before_validation :generate_whitelist, on: :create
  before_create :generate_token
  before_create :assign_province_id

  def self.find_with_whitelist(token, ip)
    where(token: token, whitelist: '*').or(where('token = ? AND whitelist LIKE ?', token, "%#{ip}%")).first
  end

  def self.filter(params = {})
    scope = all
    scope = scope.where('LOWER(name) LIKE ? OR code = ?', "%#{params[:keyword].downcase}%", params[:keyword]) if params[:keyword].present?
    scope
  end

  def map_position?
    lat.present? && lng.present?
  end

  def map_url
    "https://www.google.com/maps/@#{lat},#{lng},18z"
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

    def assign_province_id
      self.province_id = code[0..1]
    end
end
