json.array!(@module_groups) do |module_group|
  json.extract! module_group, :id
  json.url module_group_url(module_group, format: :json)
end
