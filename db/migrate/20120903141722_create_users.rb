class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :employee_id
      t.boolean :enabled
      t.string :firstname
      t.string :lastname
      t.string :password
      t.string :shortname
      t.string :username
      t.integer :account_id
      t.integer :default_location

      t.timestamps
    end
  end
end
