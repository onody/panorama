class TradesController < ApplicationController
  require "crudable"
  require "c3_line_chart"
  include CRUDable

  def chart
    @by           = params[:by] ? params[:by].to_sym : :hour
    @passed_count = params[:passed_count] ? params[:by].to_i : 12
    @chart        = C3LineChart.new(@by, @passed_count)

    vendors = Vendor.all
    vendors.each do |v|
      data = TradeHourlyStat.hourly_stats(v.id, @chart.header)
      @chart.add(v.name, data.map{|d| d[5] })
    end

    respond_to do |format|
      format.json { render json: @chart.make }
    end
  end
end
