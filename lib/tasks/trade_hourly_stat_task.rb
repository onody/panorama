module Tasks
  class TradeHourlyStatTask

    def execute
      require 'bigdecimal'

      sql = <<-SQL
        SELECT
          vendor_id,
          DATE_FORMAT(executed_at, '%Y-%m-%d %H') AS hour,
          avg(price) AS avg_price
        FROM trades
        GROUP BY vendor_id, hour
      SQL

      data = ActiveRecord::Base.connection.execute(sql)

      data.each do |r|
        TradeHourlyStat.create({
          vendor_id: r[0],
          hour:      r[1],
          avg_price: BigDecimal("#{r[2]}").floor(2).to_f
        })
      end
    end
  end
end
