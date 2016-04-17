module Tasks
  module Zaif

    class TradeTask
      include Helper

      def execute
        vendor = Vendor.where({name: 'Zaif'}).first

        response = connection(vendor.trade).get
        data = JSON.parse response.body

        data.each do |r|
          Trade.create({
            vendor_id:       vendor.id,
            trade_type:      r["trade_type"] == 'ask' ? 'SELL' : 'BUY',
            vendor_trade_id: r["tid"],
            price:           r["price"],
            amount:          r["amount"],
            executed_at:     Time.at(r["date"]).to_datetime
          })
        end
      end
    end

  end
end
