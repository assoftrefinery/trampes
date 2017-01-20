module ApplicationHelper

  #Añadir campo dinamicamente - Controls
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields btn btn-primary", data: {id: id, fields: fields.gsub("\n", "")})
  end

  #-------------------------------------------------------------------------------------------------------------

  #Ordenar columna haciendo clic en el encabezado - Todos los modelos

  #def sortable(column, title = nil)
  #  title ||= column.titleize
  #  direction = (column == params[:sort] && params[:direction] == "asc") ? "desc" : "asc"
  #  link_to title, :sort => column, :direction => direction
  #end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = (column == sort_column) ? "current #{sort_direction}" : nil
    direction = (column == sort_column && sort_direction == "asc") ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  #-------------------------------------------------------------------------------------------------------------

 # def bootstrap_class_for flash_type
 #   { success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }[flash_type] || flash_type.to_s
 # end

  #-------------------------------------------------------------------------------------------------------------

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
        concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end

  #-------------------------------------------------------------------------------------------------------------

  def bootstrap_class_for(flash_type)
    case flash_type
      when "success"
        "alert-success"   # Green
      when "error"
        "alert-danger"    # Red
      when "alert"
        "alert-warning"   # Yellow
      when "notice"
        "alert-info"      # Blue
      else
        flash_type.to_s
    end
  end

  #-------------------------------------------------------------------------------------------------------------
  #genera codigo estilo '09FATjnF9HfmupwHiMNyxw'
  def generar_codigo
    render :text=>SecureRandom.urlsafe_base64
  end

end