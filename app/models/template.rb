# == Schema Information
#
# Table name: templates
#
#  id         :bigint(8)        not null, primary key
#  content    :string           default("")
#  status     :string           default("incomplete")
#  type       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Template < ApplicationRecord
  enum status: { incomplete: "0", completed: "1", incorrect: "2" }

  # associations
  has_one_attached :audio
  has_one_attached :image

  # validations
  before_save :ensure_text_template_dont_have_audio
  before_save :ensure_voice_template_dont_have_text_content

  validates :type, presence: true
  validates :type,  allow_blank: true,
                    inclusion: {
                      in: %w(MessengerTemplate TelegramTemplate VerboiceTemplate),
                      message: I18n.t("templates.validation.invalid_type")
                    }
  validates :status, uniqueness: {
                      scope: :type,
                      message: I18n.t("templates.validation.status_not_uniq")
                    }
  validates :content, presence: {
                        message: I18n.t("presence")
                      }, if: :text_template?
  validates :audio, attached: true, if: :voice_template?

  def platform_value
    0
  end

  def self.platform_names
    platform_names = []

    platform_names << platform_build("Messenger")
    platform_names << platform_build("Telegram") if Setting.telegram_enabled?
    platform_names << platform_build("Verboice")

    platform_names
  end

  def status_value
    self.class.statuses[status]
  end

  def self.for(status, platform_name)
    find_by(status: status, type: platform_template(platform_name))
  end

  def self.send_missing_response(status, platform_name)
    platform_template(platform_name).constantize.missing_json_response(status)
  end

  private

    def self.platform_template(platform_name)
      "#{platform_name.capitalize}Template" rescue "MessengerTemplate"
    end

    def self.platform_build(name)
      [name, "#{name}Template"]
    end

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
