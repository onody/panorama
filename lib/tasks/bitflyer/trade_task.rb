module Tasks
  module Bitflyer

    class TradeTask
      include Helper

      def execute
        vendor = Vendor.where({name: 'bitFlyer'}).first

        response = connection(vendor.trade).get
        data = JSON.parse response.body

        data.each do |r|
          Trade.create({
            vendor_id:       vendor.id,
            trade_type:      r["side"],
            vendor_trade_id: r["id"],
            price:           r["price"],
            amount:          r["size"],
            executed_at:     r["exec_date"]
          })
        end
      end
    end

  end
end
