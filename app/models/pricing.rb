class Pricing < ActiveRecord::Base
  belongs_to :user
  belongs_to :pricing_style
  has_one :custom_gallery_layout
  has_many :catalogs,dependent: :destroy
  has_many :groups,dependent: :destroy
  has_one :sales_tax,dependent: :destroy
  has_one :shipping,dependent: :destroy
  has_many :discounts,dependent: :destroy
  validates :name, presence: true
  validates :pricing_style_id,presence: true
end
