class Whitelist
  def matches?(request)
    return true if Rails.env == 'development'

    klass.allowed_hosts.include?(request.remote_ip)
  end

  def self.allowed_hosts
    ENV["ALLOWED_HOSTS"].split(",").map(&:strip)
  end

  private
    def klass
      @klass ||= self.class
    end
end
