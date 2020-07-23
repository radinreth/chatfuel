# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def css_class_name
    "#{controller_path.parameterize}-#{action_name}"
  end

  def render_notice
    content_tag(:div, notice, class: "alert alert-primary", role: "alert") if notice
  end

  def render_alert
    content_tag(:div, alert, class: "alert alert-danger", role: "alert") if alert
  end

  def locale_name(locale)
    { en: "English", km: "ខ្មែរ" }[locale]
  end

  def locale_choices
    %I(en km) - [I18n.locale]
  end

  def get_css_active_class(name)
    return 'active' if params['platform'] == name
  end

  %w(homes sites dictionaries reports users).each do |ctrl|
    define_method "#{ctrl}?".to_sym do
      controller_name == ctrl
    end
  end

  def css_active_class(controller_name)
    return 'active' if params['controller'].split('/')[0] == controller_name
  end

  def display_datetime(datetime, format = :long)
    return '-' if datetime.blank?

    I18n.l(datetime, format: format)
  end

  def role_html(role_name)
    icons = { site_ombudsman: 'fa-user', site_admin: 'fa-user-friends', system_admin: 'fa-users-cog' }

    dom = "<span class='badge badge-pill badge-primary p-2 role-#{role_name}'>"
    dom += "<i class='fas #{icons[role_name.to_sym]}'></i> #{role_name}"
    dom += "</span>"
    dom
  end
end
