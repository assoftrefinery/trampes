json.array!(@trampas) do |trampa|
  json.extract! trampa, :id, :nom, :tipus, :ubicacio, :recompte, :estat_ok, :audit_id, :descripcio, :foto,:fotobase,:audit_id
  json.url trampa_url(trampa, format: :json)
end
