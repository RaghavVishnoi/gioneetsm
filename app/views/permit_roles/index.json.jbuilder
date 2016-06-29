json.array!(@permit_roles) do |permit_role|
  json.extract! permit_role, :id, :parent_role, :child_role
  json.url permit_role_url(permit_role, format: :json)
end
