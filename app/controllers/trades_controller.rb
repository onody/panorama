class TradesController < ApplicationController
  require 'crudable'
  include CRUDable

  def chart
    @trade_hourly_stats = for_chart_format

    respond_to do |format|
      format.json { render json: @trade_hourly_stats }
    end
  end

  private

  def for_chart_format
    result = []

    days = ['x']
    24.downto(1) do |i|
      days << i.hour.ago.strftime('%m-%d %H')
    end
    result << days

    vendors = Vendor.all
    vendors.each do |v|
      row = [v.name]
      24.downto(1) do |i|
        t = i.hour.ago
        ths = TradeHourlyStat.where(vendor_id: v.id, hour: Time.new(t.year, t.month, t.day, t.hour)).first
        row << (ths ? ths.avg_price : nil)
      end
      result << row
    end

    result
  end
end
