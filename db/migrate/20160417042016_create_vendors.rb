class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :api
      t.string :url_board
      t.string :url_trade

      t.timestamps null: false
    end
  end
end
