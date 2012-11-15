class AddAccountIdToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :account_id, :integer
  end
end
