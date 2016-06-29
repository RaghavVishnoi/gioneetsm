json.array!(@designations) do |designation|
  json.extract! designation, :id
  json.url designation_url(designation, format: :json)
end
