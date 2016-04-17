class Addvendors < ActiveRecord::Migration
  def up
    Vendor.create({ name: 'bitFlyer',  api: 'https://api.bitflyer.jp/v1/',      url_board: 'getboard',      url_trade: 'getexecutions' })
    Vendor.create({ name: 'Zaif',      api: 'https://api.zaif.jp/api/1/',       url_board: 'depth/btc_jpy', url_trade: 'trades/btc_jpy' })
    Vendor.create({ name: 'coincheck', api: 'https://coincheck.jp/api/',        url_board: 'order_books',   url_trade: 'trades' })
    Vendor.create({ name: 'BTCBOX',    api: 'https://www.btcbox.co.jp/api/v1/', url_board: 'depth',         url_trade: nil })
  end

  def down
    Vendor.find_by_name('bitFlyer').delete
    Vendor.find_by_name('Zaif').delete
    Vendor.find_by_name('coincheck').delete
    Vendor.find_by_name('BTCBOX').delete
  end
end
