class MobileappCustomLink < ActiveRecord::Base
	belongs_to :mobileapp
	has_attached_file :logo, :styles => { :small => "150x150>" },
                  :url  => "/assets/mobileapps_customlink_logos/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/mobileapps_customlink_logos/:id/:style/:basename.:extension"
  	validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
end
