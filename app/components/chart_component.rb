class ChartComponent < ViewComponent::Base
  with_content_areas :head, :body

  def initialize(target: '')
    @target = target
  end
end
