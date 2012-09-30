class CreateGenders < ActiveRecord::Migration
  def change
    create_table :genders do |t|
      t.string :description

      t.timestamps
    end
  end
end
