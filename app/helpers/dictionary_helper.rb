module DictionaryHelper
  def toggle_class_name(class_name, truthy)
    class_name if truthy
  end

  def link_to_new(resource)
    link_to t("new_#{resource}"), send(:"new_#{resource}_path"), class: "btn btn-primary"
  end

  def active_if(bool)
    toggle_class_name("active", bool)
  end
end
