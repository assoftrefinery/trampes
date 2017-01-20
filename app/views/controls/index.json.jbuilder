json.array!(@controls) do |control|
  json.extract! control, :id, :nom, :datacontrol, :operari
  json.url control_url(control, format: :json)
end
