class Vendor < ActiveRecord::Base
  has_many :trades
  has_many :trade_hourly_stats

  def trade
    self.api + self.url_trade
  end
end
