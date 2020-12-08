class ChartComponent < ViewComponent::Base
  with_content_areas :body

  def initialize(name: '')
    @name = name
  end
end
