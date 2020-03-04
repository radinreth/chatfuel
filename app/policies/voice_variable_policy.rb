class VoiceVariablePolicy < ApplicationPolicy
  def update?
    user.system_admin?
  end
end
