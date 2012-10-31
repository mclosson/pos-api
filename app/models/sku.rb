class Sku < ActiveRecord::Base
  attr_accessible :article_id, :color, :cost_price, :cost_price_igic, :description, :gender_id, :inactive, :inbound_date, :inbound_qty, :location_id, :lost_qty, :min_stock_integer, :model, :outbound_qty, :sales_price, :season_id, :sex, :sku, :supplier_id, :synchronized, :transferred_in_qty, :transferred_qty, :unit_size_id

  belongs_to :location
  belongs_to :article
  belongs_to :gender
  belongs_to :season
  belongs_to :supplier
  belongs_to :unit_size

  validates :sku, presence: true, uniqueness: true
  validates :sales_price, presence: true, numericality: true
  validates :description, presence: true

  def as_json(options = {})
    super({
      include: {
        article: { only: [:id, :description, :notes] },
        gender: { only: [:id, :description] },
        season: { only: [:id, :name] },
        supplier: { only: [:id, :name] },
        unit_size: { only: [:id, :size, :description] }
      },
      except: [
        :article_id, 
        :gender_id,
        :season_id,
        :supplier_id,
        :unit_size_id,
        :sex, # will be removing this column from the database, not used anymore
        :sales_price # being replaced with sales_price_with_currency
      ],
      methods: [
        :sales_price_with_currency
      ]
    })
  end
 
  def sales_price_with_currency
    "$%.2f" % sales_price
  end
end
