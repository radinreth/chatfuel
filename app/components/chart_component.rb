class ChartComponent < ViewComponent::Base
  with_content_areas :addon, :subheader, :body, :config

  def initialize(name: '', downloadable: true, filterable: false)
    @name = name
    @downloadable = downloadable
    @filterable = filterable
  end
end
