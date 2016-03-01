json.array!(@audits) do |audit|
  json.extract! audit, :id, :dataaudit, :observacions
  json.url audit_url(audit, format: :json)
end
