class MenuItemPolicy < Struct.new(:user, :menu_item)
  def index?
    !user&.site_ombudsman?
  end
end
