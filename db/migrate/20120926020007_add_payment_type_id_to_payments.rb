class AddPaymentTypeIdToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :payment_type_id, :integer
  end
end
