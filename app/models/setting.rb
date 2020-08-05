# == Schema Information
#
# Table name: settings
#
#  id         :bigint(8)        not null, primary key
#  value      :text
#  var        :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_settings_on_var  (var) UNIQUE
#
class Setting < RailsSettings::Base
  cache_prefix { "v1" }

  # Define your fields
  field :default_locale, default: "en", type: :string
  # field :confirmable_enable, default: "0", type: :boolean
  # field :admin_emails, default: "admin@rubyonrails.org", type: :array
  # field :omniauth_google_client_id, default: (ENV["OMNIAUTH_GOOGLE_CLIENT_ID"] || ""), type: :string, readonly: true
  # field :omniauth_google_client_secret, default: (ENV["OMNIAUTH_GOOGLE_CLIENT_SECRET"] || ""), type: :string, readonly: true

  ENABLED_OPTIONS = %w(1 enable enabled true on yes)
  def self.messenger_notification_enabled?
    ENABLED_OPTIONS.include?(ENV['FB_NOTIFY_ENABLED'].downcase)
  end

  def self.telegram_notification_enabled?
    ENABLED_OPTIONS.include?(ENV['TG_NOTIFY_ENABLED'].downcase)
  end
end
