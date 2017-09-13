class Privilege < ActiveRecord::Base
  #Association
  belongs_to :gallery
  # validates  :gallery_access_code, length: {minimum: 6, message: "Access Code must be at least 6 characters."}
end
