json.array!(@vendors) do |vendor|
  json.extract! vendor, :id, :name, :api, :url_board, :url_trade
  json.url vendor_url(vendor, format: :json)
end
