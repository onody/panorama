class Vendor < ActiveRecord::Base

  def trade
    self.api + self.url_trade
  end
end
