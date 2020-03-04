class MenuItemPolicy < Struct.new(:user, :menu_item)
  def show?
    user.present? && !user.ombudsman?
  end
end
