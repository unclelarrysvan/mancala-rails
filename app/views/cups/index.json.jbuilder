json.array!(@cups) do |cup|
  json.extract! cup, :marbles
  json.url cup_url(cup, format: :json)
end
