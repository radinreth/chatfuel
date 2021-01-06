class ChartComponent < ViewComponent::Base
  with_content_areas :addon, :subheader, :body, :config

  def initialize(name: '', collection: [], filterable: false)
    @name = name
    @collection = collection
    @filterable = filterable
  end
end
