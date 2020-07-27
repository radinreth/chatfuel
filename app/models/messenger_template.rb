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
  include Rails.application.routes.url_helpers

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

  private
  
  def attachment
    return unless self.image && self.image.attached?

    {
      type: 'image',
      payload: { url: rails_blob_path(self.image, disposition: 'attachment') }
    }
  end

end
