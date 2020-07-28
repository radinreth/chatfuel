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
class MessengerTemplate < Template

  def self.model_name
    Template.model_name
  end

  def platform_value
    0
  end

  def human_name
    'messenger'
  end

  def json_response
    response = { messages: [] }
    response[:messages] << { attachment: attachment } if attachment
    response[:messages] << { text: self.content }
    response
  end

  def self.missing_json_response status
    image_url = URI.join(ENV['BASE_URL'], ActionController::Base.helpers.asset_path("ticket-responses/#{status}.png"))

    {
      messages: [
        { attachment: image_url },
        { text: I18n.t("tickets.#{status}.content", locale: :km) }
      ]
    }
  end

  private

  def attachment
    return unless self.image && self.image.attached?

    image_url = URI.join(ENV['BASE_URL'], rails_blob_path(self.image, only_path: true))
    {
      type: 'image',
      payload: { url: image_url }
    }
  end

end
