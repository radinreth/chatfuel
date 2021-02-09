class SearchFormComponent < ViewComponent::Base
  with_content_areas :action

  def initialize(placeholder:, url:)
    @placeholder = placeholder
    @url = url
  end
end
