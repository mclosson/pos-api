class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :description
      t.text :notes
      t.boolean :inactive

      t.timestamps
    end
  end
end
