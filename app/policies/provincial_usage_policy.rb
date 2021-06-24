class ProvincialUsagePolicy < Struct.new(:user, :provincial_usage)
  def index?
    true
  end
end
