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
class TelegramTemplate < Template
  def self.model_name
    Template.model_name
  end

  def platform_value
    1
  end

  def human_name
    "telegram"
  end

  def json_response
    { messages: self.content }
  end

  def self.missing_json_response status
    { messages: I18n.t("tickets.#{status}.content", locale: :km) }
  end

end
