class PaymentType < ActiveRecord::Base
  attr_accessible :description, :location_id
end
