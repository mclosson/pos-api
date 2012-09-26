class CreatePaymentTypes < ActiveRecord::Migration
  def change
    create_table :payment_types do |t|
      t.integer :location_id
      t.string :description

      t.timestamps
    end
  end
end
