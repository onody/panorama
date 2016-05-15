json.array!(@trade_hourly_stats) do |trade_hourly_stat|
  json.extract! trade_hourly_stat, :id, :vendor_id, :hour, :avg_price
  json.url trade_hourly_stat_url(trade_hourly_stat, format: :json)
end
