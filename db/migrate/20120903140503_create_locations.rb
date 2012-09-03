class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address1
      t.string :address2
      t.string :city
      t.text :description
      t.boolean :direct_distribution
      t.string :fax
      t.boolean :active
      t.boolean :overwrite_cost_price
      t.boolean :overwrite_sales_price
      t.boolean :overwrite_season
      t.string :phone
      t.string :province
      t.boolean :round_sales_price
      t.string :short_description
      t.string :zipcode
      t.integer :account_id

      t.timestamps
    end
  end
end
