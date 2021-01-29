class GenderItemComponent < ViewComponent::Base
  def initialize(value:, label:, f:, checked: false)
    @f = f
    @value = value
    @label = label
    @checked = checked
  end
end
