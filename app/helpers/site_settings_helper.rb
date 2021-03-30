module SiteSettingsHelper
  def chat_groups_html(site_setting)
    chat_groups = site_setting.telegram_chat_groups

    return '-' unless chat_groups.present?

    chat_groups.map do |chat_group|
      "<span class=#{('line-through' unless chat_group.is_active)}>#{chat_group.title}</span>"
    end.join(', ')
  end
end
