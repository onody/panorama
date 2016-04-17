json.array!(@trades) do |trade|
  json.extract! trade, :id, :vendor_id, :vendor_trade_id, :price, :amount, :executed_at
  json.url trade_url(trade, format: :json)
end
