json.array!(@user_parents) do |user_parent|
  json.extract! user_parent, :id
  json.url user_parent_url(user_parent, format: :json)
end
