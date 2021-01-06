module DashboardHelper
  def subheader
    return "" if @criteria.nil?

    content_tag :span, class: "" do
      "#{@criteria.variable_name} " \
      " &raquo; #{@criteria.mapping_value}".html_safe
    end
  end
end
