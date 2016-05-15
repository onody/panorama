json.array!(@trades.order("executed_at DESC")) do |trade|
  json.extract! trade, :id, :vendor_id, :trade_type, :price, :amount, :executed_at
  json.vendor_name trade.vendor.name
  # json.url trade_url(trade, format: :json)
end
