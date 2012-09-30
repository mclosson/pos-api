class CreateSkus < ActiveRecord::Migration
  def change
    create_table :skus do |t|
      t.string :sku
      t.integer :location_id
      t.text :description
      t.datetime :inbound_date
      t.integer :supplier_id
      t.integer :article_id
      t.integer :gender_id
      t.string :sex
      t.string :model
      t.integer :inbound_qty
      t.integer :outbound_qty
      t.integer :lost_qty
      t.integer :transferred_qty
      t.integer :transferred_in_qty
      t.string :min_stock_integer
      t.float :sales_price
      t.float :cost_price
      t.float :cost_price_igic
      t.boolean :inactive
      t.integer :unit_size_id
      t.string :color
      t.boolean :synchronized
      t.integer :season_id

      t.timestamps
    end
  end
end
