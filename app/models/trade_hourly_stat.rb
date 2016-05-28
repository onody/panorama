class TradeHourlyStat < ActiveRecord::Base
  validates :vendor_id, uniqueness: { scope: [:trade_type, :hour] } # 組み合わせで一意


  def self.hourly_stats(vendor_id, arr_hours)
    sql = <<-SQL
      SELECT *
      FROM #{ sql_cal(arr_hours) }
      LEFT JOIN (
        SELECT *
        FROM trade_hourly_stats
        WHERE vendor_id = #{ vendor_id } AND trade_type = 'MID'
        AND (hour >= '#{ arr_hours.first.utc.to_formatted_s(:db) }' OR hour <= '#{ arr_hours.last.utc.to_formatted_s(:db) }')
      ) AS ths
      ON cal.hour = ths.hour
    SQL
    ActiveRecord::Base.connection.execute(sql)
  end

  def self.sql_cal(arr_hours)
    sql = "("
    arr_hours.each_with_index do |d, index|
      if index == (arr_hours.size - 1)
        sql += " SELECT '#{ d.utc.to_formatted_s(:db) }' AS hour"
      else
        sql += "SELECT '#{ d.utc.to_formatted_s(:db) }' AS hour UNION "
      end
    end
    sql += ") AS cal"
  end
end
