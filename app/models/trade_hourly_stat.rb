class TradeHourlyStat < ActiveRecord::Base
  validates :vendor_id, uniqueness: { scope: [:trade_type, :hour] } # 組み合わせで一意
end
