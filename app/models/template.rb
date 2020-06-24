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
  validate :text_template, if: :text_template?
  validate :voice_template, if: :voice_template?

  validates :type, presence: true
  validates :content, presence: true
  validates :type,  allow_blank: true,
                    inclusion: {
                      in: %w(MessengerTemplate TelegramTemplate VerboiceTemplate),
                      message: "%{value} is not a valid type"
                    }

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

  private
    def text_template
      return if !audio.attached? && content.present?

      errors.add(:base, "invalid template provided")
    end

    def voice_template
      return if audio.attached? && content.blank?

      errors.add(:base, "invalid template provided")
    end

    def text_template?
      type == "MessengerTemplate" ||
      type == "TelegramTemplate"
    end

    def voice_template?
      type == "VerboiceTemplate"
    end
end
