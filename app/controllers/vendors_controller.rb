class VendorsController < ApplicationController
  require "crudable"
  include CRUDable
  include Chart

  def chart
    raise "param 'id' is required" unless params[:vendor_id]
    @trade_hourly_stats = vendor_chart(params[:vendor_id])

    respond_to do |format|
      format.json { render json: @trade_hourly_stats }
    end
  end
end
