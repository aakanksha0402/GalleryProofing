class Label < ActiveRecord::Base
  belongs_to :gallery
  has_many :label_photos, dependent: :destroy
  has_many :photos, through: :label_photos
end
