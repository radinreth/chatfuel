class SelectComponent < ViewComponent::Base
  def initialize(name:, value:, input_type: "radio", title: "", checked: false, disabled: false)
    @name = name
    @value = value
    @title = title
    @checked = checked
    @disabled = disabled
    @input_type = input_type
  end
end
