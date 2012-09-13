class Sku
#  extend ActiveModel::Serializers::JSON
  include ActiveModel::Serialization
 
  attr_accessor :attributes
  
  def initialize(attributes)
    @attributes = attributes
  end
  
  SAMPLES = {
    '100' => {
      'sku_inbound_date' => Time.now.strftime("%m-%d-%Y"),
      'sku_sales_price' => 50.00,
      'description' => "Shirt",
      'supplier_name' => "Hurley Clothing",
      'supplier_id' => 1,
      'article_description' => "Island style button up shirt",
      'gender_id' => 1,
      'model' => "not sure what should go here...",
      'size' => "XL",
      'article_id' => 1,
      'season_id' => 1,
      'quantity' => 7
    },
    '101' => {
      'sku_inbound_date' => Time.now.strftime("%m-%d-%Y"),
      'sku_sales_price' => 35.00,
      'description' => "Board Shorts",
      'supplier_name' => "Hurley Clothing",
      'supplier_id' => 1,
      'article_description' => "Blue and Black Surf Shorts",
      'gender_id' => 1,
      'model' => "not sure what should go here...",
      'size' => "L",
      'article_id' => 2,
      'season_id' => 1,
      'quantity' => 13
    },
    '102' => {
      'sku_inbound_date' => Time.now.strftime("%m-%d-%Y"),
      'sku_sales_price' => 20.00,
      'description' => "Sunglasses",
      'supplier_name' => "Hurley Clothing",
      'supplier_id' => 1,
      'article_description' => "Mirrored Sunglasses",
      'gender_id' => 1,
      'model' => "not sure what should go here...",
      'size' => "",
      'article_id' => 3,
      'season_id' => 1,
      'quantity' => 32
    }
  }

  def self.test_data(id)
    SAMPLES[id]
  end

end
