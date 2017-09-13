class CustomGalleryLayout < ActiveRecord::Base

  belongs_to :gallery
  belongs_to :automation_series
  belongs_to :color_logo
  belongs_to :category
  belongs_to :pricing
  GALLERY_ACCESS_PRIVACY = [['Public_No Password','public_no_password'],['Public Password','public_password'],['Private No Password','private_no_password'],['Private Password','private_password']]
  STATUS = [['Active','Active'],['Inactive','Inactive']]


  # def should_generate_new_friendly_id?
  #   new_record?
  # end
end
