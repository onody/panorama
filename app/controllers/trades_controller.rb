class TradesController < ApplicationController
  require 'crudable'
  include CRUDable
  include Chart

  def chart
    @trade_hourly_stats = all_chart

    respond_to do |format|
      format.json { render json: @trade_hourly_stats }
    end
  end
end
