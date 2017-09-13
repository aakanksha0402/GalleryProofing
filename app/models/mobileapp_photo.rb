class MobileappPhoto < ActiveRecord::Base
	# belongs_to :mobileapp

	has_attached_file :photo, :styles => { :small => "150x150>" },
                  :url  => "/assets/mobileapps_photos/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/mobileapps_photos/:id/:style/:basename.:extension"
  	validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
end
