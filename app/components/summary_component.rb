class SummaryComponent < ViewComponent::Base
  with_content_areas :fa_icon, :title, :desc, :config

  def initialize(style: , count:)
    @style = style
    @count = count
  end
end
