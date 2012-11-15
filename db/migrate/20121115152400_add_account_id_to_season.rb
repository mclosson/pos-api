class AddAccountIdToSeason < ActiveRecord::Migration
  def change
    add_column :seasons, :account_id, :integer
  end
end
