json.array!(@targets) do |target|
  json.extract! target, :id
  json.url target_url(target, format: :json)
end
