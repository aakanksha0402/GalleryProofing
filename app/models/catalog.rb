class Catalog < ActiveRecord::Base
  belongs_to :pricing
  belongs_to :group
  belongs_to :fix_group
  has_many :digital_media_prices,dependent: :destroy
  has_many :line_items, dependent: :destroy
  accepts_nested_attributes_for :digital_media_prices


  def catalog_price
    price
  end
end
