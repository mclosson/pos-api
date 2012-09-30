class Sku < ActiveRecord::Base
  attr_accessible :article_id, :color, :cost_price, :cost_price_igic, :description, :gender_id, :inactive, :inbound_date, :inbound_qty, :location_id, :lost_qty, :min_stock_integer, :model, :outbound_qty, :sales_price, :season_id, :sex, :sku, :supplier_id, :synchronized, :transferred_in_qty, :transferred_qty, :unit_size_id
end
