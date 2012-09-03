class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :sales_ticket_id
      t.integer :quantity
      t.float :sales_price
      t.string :sku
      t.boolean :void
      t.integer :discount

      t.timestamps
    end
  end
end
