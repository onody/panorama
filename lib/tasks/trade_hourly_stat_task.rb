module Tasks
  class TradeHourlyStatTask
    def execute
      require "bigdecimal"

      # 毎時の売り、買いごとの平均値を保存
      data = ActiveRecord::Base.connection.execute(sql_hourly_avg)
      data.each do |r|
        TradeHourlyStat.create({
          vendor_id:  r[0],
          trade_type: r[1],
          hour:       r[2],
          avg_price:  BigDecimal("#{r[3]}").floor(2).to_f,
        })
      end

      # 毎時の売買の平均値を保存
      data = ActiveRecord::Base.connection.execute(sql_buy_sell_avg)
      data.each do |r|
        TradeHourlyStat.create({
          vendor_id:  r[0],
          trade_type: "MID",
          hour:       r[1],
          avg_price:  BigDecimal("#{r[2]}").floor(2).to_f,
        })
      end
    end

    private

    def sql_hourly_avg
      <<-SQL
        SELECT
          vendor_id,
          trade_type,
          DATE_FORMAT(executed_at, '%Y-%m-%d %H') AS hour,
          avg(price) AS avg_price
        FROM trades
        GROUP BY vendor_id, trade_type, hour
      SQL
    end

    def sql_buy_sell_avg
      <<-SQL
        SELECT
          vendor_id,
          hour,
          avg(avg_price) AS avg_price
        FROM trade_hourly_stats
        GROUP BY vendor_id, hour
      SQL
    end
  end
end
