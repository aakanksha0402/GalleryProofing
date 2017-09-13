class Contact < ActiveRecord::Base
  belongs_to :brand
  belongs_to :country
  belongs_to :state_province
  has_many :galleries, dependent: :destroy
  has_many :referred_contacts, dependent: :destroy

  validates :firstname, presence: {message: "Enter the contact's first name."}
  validates :email, presence: {message: "Enter the contact's email address."}
  # validates :email, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Enter a valid email address." }
  # validates_email_realness_of :email
  # validates :pincode, presence: {:message => 'Please enter pincode for brand contact.'}
  validates :pincode, length: { maximum: 10, too_long: "Please enter valid postal code."}
  validates :pincode, format: { with: /\A[a-z0-9\-_]+\z/i, message: "Enter a valid postal code." }
  accepts_nested_attributes_for :referred_contacts

  acts_as_taggable_on :tags

  scope :name_email, lambda{|n_m| where("contacts.email ILIKE ? or firstname ILIKE ? or lastname ILIKE ?", "%#{n_m}%", "%#{n_m}%", "%#{n_m}%")}
  scope :gallery, lambda{|g| joins(:galleries).where("galleries.id = ?", g)}
  scope :tag, lambda{|t| joins("LEFT JOIN taggings on contacts.id = taggings.taggable_id").joins("LEFT JOIN tags on tags.id = taggings.tag_id").where("tags.name ILIKE ?", "%#{t}%")}
  scope :brand, lambda{|b| joins(:brand).where("contacts.brand_id = ?", b)}

  def self.to_csv()
    attributes = %w{firstname lastname email address1 address2 city country pincode phone_number buisinessname tags referredby}
    CSV.generate(headers: true) do |csv|
      csv << attributes
        all.each do |contact|
          csv << attributes.map{ |attr| contact.send(attr) }
        end
    end
  end

  def combined_name_for_collection_select
    "#{self.lastname}, #{self.firstname}"
  end
end
