class ManifestPolicy < Struct.new(:user, :manifest)
  def show?
    true
  end
end
