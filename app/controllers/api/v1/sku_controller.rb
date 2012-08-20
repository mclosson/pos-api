class Api::V1::SkuController < Api::V1::ApiController
  def details
    respond_with Sku.new
  end
end
