class SalesTicket < ActiveRecord::Base
  attr_accessible :location_id, :multi_payment, :payment_type, :refunds_returns_allowed, :sales_person_id, :synchronized, :tax_amount, :tax_rate, :ticket_cleared, :ticket_cleared_datetime, :ticket_datetime, :ticket_expired, :ticket_expired_refund, :vip_client_id, :void
  belongs_to :location
  has_many :line_items, :dependent => :destroy
  validates :location_id, presence: true

  def add_line_item(sku)
    self.line_items.create(:sku => sku)
  end

end
