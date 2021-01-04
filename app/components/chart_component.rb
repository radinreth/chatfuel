class ChartComponent < ViewComponent::Base
  with_content_areas :addon, :subheader, :body, :config

  def initialize(name: '', filterable: false)
    @name = name
    @filterable = filterable
  end
end
