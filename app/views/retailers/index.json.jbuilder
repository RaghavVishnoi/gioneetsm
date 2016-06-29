json.array!(@retailers) do |retailer|
  json.extract! retailer, :id
  json.url retailer_url(retailer, format: :json)
end
