class MenuItemPolicy < Struct.new(:user, :menu_item)
  def show?
    !user&.site_ombudsman?
  end
end
