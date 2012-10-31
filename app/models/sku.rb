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

  # define json options as constant, or you could return them from a method
  #   EVENT_JSON_OPTS = { :include => { :locations => { :only => [:id], :methods => [:name] } } }
  #

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
        :sex # will be removing this column from the database, not used anymore
      ]
    })
  end
 
end
