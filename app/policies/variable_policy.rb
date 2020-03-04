class VariablePolicy < ApplicationPolicy
  def index?
    user.system_admin?
  end
end
