class SelectComponent < ViewComponent::Base
  def initialize(name:, value:, checked: false, disabled: false)
    @name = name
    @value = value
    @checked = checked
    @disabled = disabled
  end
end
