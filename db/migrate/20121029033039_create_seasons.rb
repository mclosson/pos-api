class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.string :name
      t.boolean :close_out
      t.boolean :inactive

      t.timestamps
    end
  end
end
