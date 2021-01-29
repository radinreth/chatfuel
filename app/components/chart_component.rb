class ChartComponent < ViewComponent::Base
  with_content_areas :addon, :subheader, :body, :config, :hint

  def initialize(name: '', downloadable: true)
    @name = name
    @downloadable = downloadable
  end
end
