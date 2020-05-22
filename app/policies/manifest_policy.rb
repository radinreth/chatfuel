class ManifestPolicy < Struct.new(:user, :manifest)
  def show?
    user.system_admin?
  end
end
