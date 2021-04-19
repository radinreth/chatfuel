class ChartAddonComponent < ViewComponent::Base
  def initialize(visibility:, path:, formater:, canvasid:)
    @visibility = visibility
    @path = path
    @formater = formater
    @canvasid = canvasid
  end
end
