class Trade < ActiveRecord::Base
  validates :vendor_trade_id, uniqueness: { scope: :vendor_id } # 組み合わせで一意
  belongs_to :vendor
end
