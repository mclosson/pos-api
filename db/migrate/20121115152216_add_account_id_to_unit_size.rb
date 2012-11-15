class AddAccountIdToUnitSize < ActiveRecord::Migration
  def change
    add_column :unit_sizes, :account_id, :integer
  end
end
