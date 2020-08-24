module DictionariesHelper
  def chartjs_colors
    @chartjs_colors ||= %w(#f63e3e #1cc88a #4e73df #7400b8 #bdb2ff #bc6c25 #5e6472 #ff5d8f #fee440 #1a936f)
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + '_fields', f: builder)
    end

    link_to(name.html_safe, '#', class: "add_#{association} btn btn-link text-decoration-none", data: { id: id, fields: fields.gsub("\n", '') })
  end
end
