class MarkAsBlockOptionComponent < ViewComponent::Base
  def initialize(name:, checked:, disabled:, title:)
    @name = name
    @checked = checked
    @disabled = disabled
    @title = title
  end
end
