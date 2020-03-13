module DictionaryHelper
  def toggle_class_name(class_name, truthy)
    class_name if truthy
  end
end
