json.array!(@auditvs) do |auditv|
  json.extract! auditv, :id, :dataaudit, :observacions
  json.url auditv_url(auditv, format: :json)
end
