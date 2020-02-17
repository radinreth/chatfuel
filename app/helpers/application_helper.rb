# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def css_class_name
    "#{controller_path.parameterize}-#{action_name}"
  end

  def render_notice
    content_tag(:p, notice, class: 'notice') if notice
  end

  def render_alert
    content_tag(:p, alert, class: 'alert') if alert
  end
end
