class DictionaryModalComponent < ViewComponent::Base
  with_content_areas :body

  def initialize(url:, modal_id:)
    @url = url
    @modal_id = modal_id
  end
end
