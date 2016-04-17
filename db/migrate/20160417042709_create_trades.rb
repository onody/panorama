class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.integer  :vendor_id,       unsigned: true, null: false
      t.integer  :vendor_trade_id, unsigned: true
      t.string   :trade_type
      t.float    :price,           unsigned: true
      t.float    :amount,          unsigned: true
      t.datetime :executed_at

      t.timestamps null: false
    end
  end
end
