class AddAccountIdToGender < ActiveRecord::Migration
  def change
    add_column :genders, :account_id, :integer
  end
end
