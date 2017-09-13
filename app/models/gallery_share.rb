class GalleryShare < ActiveRecord::Base
  belongs_to :email_template
  belongs_to :gallery

  def email_address
    recipient
  end

  scope :gallery_id, lambda {|id| joins(:gallery).where('galleries.id = ?',id)}

  scope :email, lambda{|email| where('recipient ILIKE ? ', "%#{email}%" )}

end
