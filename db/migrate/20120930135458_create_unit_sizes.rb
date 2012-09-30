class CreateUnitSizes < ActiveRecord::Migration
  def change
    create_table :unit_sizes do |t|
      t.string :size
      t.string :description

      t.timestamps
    end
  end
end
