class CreateTradeHourlyStats < ActiveRecord::Migration
  def change
    create_table :trade_hourly_stats do |t|
      t.integer :vendor_id, unsigned: true, null: false
      t.datetime :hour
      t.float   :avg_price, unsigned: true, null: false
    end
    add_index :trade_hourly_stats, [:vendor_id, :hour], name: 'additional_idx01'
  end
end
