class AddRegistrationCodeToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :registration_code, :string
  end
end
