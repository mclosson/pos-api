class Sku
  extend ActiveModel::Serializers::JSON

  def as_json(options = {})
    {name: 'matt', age: 30, happy: Time.now}
  end
end
