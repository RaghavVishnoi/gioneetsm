json.array!(@sales_beats) do |sales_beat|
  json.extract! sales_beat, :id
  json.url sales_beat_url(sales_beat, format: :json)
end
