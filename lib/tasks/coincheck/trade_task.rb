module Tasks
  module Coincheck

    class TradeTask
      include Helper

      def execute
        vendor = Vendor.where({name: 'coincheck'}).first

        response = connection(vendor.trade).get
        data = JSON.parse response.body

        data.each do |r|
          Trade.create({
            vendor_id:       vendor.id,
            trade_type:      r["order_type"] == 'sell' ? 'SELL' : 'BUY',
            vendor_trade_id: r["id"],
            price:           r["rate"],
            amount:          r["amount"],
            executed_at:     r["created_at"]
          })
        end
      end
    end

  end
end
