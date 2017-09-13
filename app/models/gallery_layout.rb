class GalleryLayout < ActiveRecord::Base
  belongs_to :brand
  belongs_to :automation_series
  belongs_to :color_logo
  validates :name, presence: true
end
