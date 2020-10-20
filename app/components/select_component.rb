class SelectComponent < ViewComponent::Base
  def initialize(name:, value:, title: "", checked: false, disabled: false)
    @name = name
    @value = value
    @title = title
    @checked = checked
    @disabled = disabled
  end
end
