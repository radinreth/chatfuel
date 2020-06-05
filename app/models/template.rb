# == Schema Information
#
# Table name: templates
#
#  id         :bigint(8)        not null, primary key
#  content    :string           default("")
#  status     :string           default("0")
#  type       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Template < ApplicationRecord
  enum status: { incomplete: "0", completed: "1", incorrect: "2" }

  # associations
  has_one_attached :audio

  # validations
  validates :content, presence: true
  validates :status, uniqueness: { scope: :type }

  def platform_value
    0
  end

  def self.platform_names
    [
      ["Messenger", "MessengerTemplate"],
      ["Telegram", "TelegramTemplate"],
      ["Verboice", "VerboiceTemplate"]
    ]
  end

  def status_value
    self.class.statuses[status]
  end
end
