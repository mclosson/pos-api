class LineItem < ActiveRecord::Base
  attr_accessible :discount, :quantity, :sales_price, :sales_ticket_id, :sku, :void
  belongs_to :sales_ticket
end
