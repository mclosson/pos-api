class CreateSuppliers < ActiveRecord::Migration
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :telephone
      t.text :notes
      t.boolean :inactive
      t.integer :margin

      t.timestamps
    end
  end
end
