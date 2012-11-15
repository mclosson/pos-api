class AddAccountIdToSupplier < ActiveRecord::Migration
  def change
    add_column :suppliers, :account_id, :integer
  end
end
