class RemoveSexFromSkus < ActiveRecord::Migration
  def up
    remove_column :skus, :sex
  end

  def down
    add_column :skus, :sex, :string
  end
end
