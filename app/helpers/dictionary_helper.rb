module DictionaryHelper
  def toggle_class_name(class_name, truthy)
    class_name if truthy
  end

  def link_to_new(resource)
    link_to "New #{resource}", send(:"new_#{resource}_path"), class: "btn btn-primary"
  end
end
