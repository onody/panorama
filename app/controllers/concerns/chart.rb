module Chart
  extend ActiveSupport::Concern

  def vendor_chart(vendor_id, start_at = nil, end_at = nil)
    term = terms(start_at, end_at)

    result = []
    result << ["x", term.map{|t| t.strftime("%m-%d %H")}].flatten

    types = %w(BUY SELL MID)
    types.each do |v|
      row = [v]
      term.each do |i|
        ths = TradeHourlyStat.where(vendor_id: vendor_id, trade_type: v, hour: i).first
        row << (ths ? ths.avg_price : nil)
      end
      result << row
    end
    result
  end

  def all_chart(start_at = nil, end_at = nil)
    term = terms(start_at, end_at)

    result = []
    result << ["x", term.map{|t| t.strftime("%m-%d %H")}].flatten

    vendors = Vendor.all
    vendors.each do |v|
      row = [v.name]
      term.each do |i|
        ths = TradeHourlyStat.where(vendor_id: v.id, trade_type: "MID", hour: i).first
        row << (ths ? ths.avg_price : nil)
      end
      result << row
    end
    result
  end

  def terms(start_at = nil, end_at = nil)
    start_at ||= Time.now.ago(25.hours).change(min: 0, sec: 0)
    end_at   ||= Time.now.ago(1.hour).change(min: 0, sec: 0)

    past_hour = ((end_at - start_at) / 60 / 60).to_i
    result = []
    past_hour.times do |h|
      result << end_at.ago(h.hours)
    end
    result.reverse
  end
end
