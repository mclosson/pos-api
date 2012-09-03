class CreateSalesTickets < ActiveRecord::Migration
  def change
    create_table :sales_tickets do |t|
      t.integer :location_id
      t.boolean :multi_payment
      t.integer :payment_type
      t.boolean :refunds_returns_allowed
      t.integer :sales_person_id
      t.boolean :synchronized
      t.float :tax_amount
      t.float :tax_rate
      t.boolean :ticket_cleared
      t.datetime :ticket_cleared_datetime
      t.datetime :ticket_datetime
      t.datetime :ticket_expired
      t.datetime :ticket_expired_refund
      t.integer :vip_client_id
      t.boolean :void

      t.timestamps
    end
  end
end
