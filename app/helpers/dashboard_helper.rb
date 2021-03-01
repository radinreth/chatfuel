module DashboardHelper
  def subheader
    return "" if @criteria.nil?

    content_tag :span, class: "" do
      "#{@criteria.variable_name} " \
      " &raquo; #{@criteria.mapping_value}".html_safe
    end
  end

  def open_config_modal(target)
    if policy(:dashboard).setting?
      link_to "#", class: "ml-2", data: { toggle: "modal", target: target } do
        content_tag :i, nil, class: "fas fa-cog cog"
      end
    end
  end

end
