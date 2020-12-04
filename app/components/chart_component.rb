class ChartComponent < ViewComponent::Base
  with_content_areas :head, :body

  def initialize(id: '')
    @id = id
  end
end
