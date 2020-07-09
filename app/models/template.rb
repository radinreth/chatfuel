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
  before_save :ensure_text_template_dont_have_audio
  before_save :ensure_voice_template_dont_have_text_content

  validates :type, presence: true
  validates :type,  allow_blank: true,
                    inclusion: {
                      in: %w(MessengerTemplate TelegramTemplate VerboiceTemplate),
                      message: "%{value} is not a valid type"
                    }
  validates :status, uniqueness: { scope: :type }
  validates :content, presence: true, if: :text_template?
  validates :audio, attached: true, if: :voice_template?

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

    def ensure_text_template_dont_have_audio
      audio.purge_later if audio.attached? && text_template?
    end

    def ensure_voice_template_dont_have_text_content
      self.content = "" if voice_template?
    end

    def text_template?
      type == "MessengerTemplate" ||
      type == "TelegramTemplate"
    end

    def voice_template?
      type == "VerboiceTemplate"
    end
end
