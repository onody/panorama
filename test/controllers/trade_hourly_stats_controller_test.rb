require 'test_helper'

class TradeHourlyStatsControllerTest < ActionController::TestCase
  setup do
    @trade_hourly_stat = trade_hourly_stats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trade_hourly_stats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trade_hourly_stat" do
    assert_difference('TradeHourlyStat.count') do
      post :create, trade_hourly_stat: { avg_price: @trade_hourly_stat.avg_price, hour: @trade_hourly_stat.hour, vendor_id: @trade_hourly_stat.vendor_id }
    end

    assert_redirected_to trade_hourly_stat_path(assigns(:trade_hourly_stat))
  end

  test "should show trade_hourly_stat" do
    get :show, id: @trade_hourly_stat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @trade_hourly_stat
    assert_response :success
  end

  test "should update trade_hourly_stat" do
    patch :update, id: @trade_hourly_stat, trade_hourly_stat: { avg_price: @trade_hourly_stat.avg_price, hour: @trade_hourly_stat.hour, vendor_id: @trade_hourly_stat.vendor_id }
    assert_redirected_to trade_hourly_stat_path(assigns(:trade_hourly_stat))
  end

  test "should destroy trade_hourly_stat" do
    assert_difference('TradeHourlyStat.count', -1) do
      delete :destroy, id: @trade_hourly_stat
    end

    assert_redirected_to trade_hourly_stats_path
  end
end
