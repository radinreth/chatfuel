class MenuItemPolicy < Struct.new(:user, :menu_item)
  def show?
    !user&.ombudsman?
  end
end
