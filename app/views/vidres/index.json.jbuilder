json.array!(@vidres) do |vidre|
  json.extract! vidre, :id, :nom, :tipus, :ubicacio, :descripcio, :fotobase, :recompte, :estat_ok, :observacions, :foto, :auditv_id
  json.url vidre_url(vidre, format: :json)
end
