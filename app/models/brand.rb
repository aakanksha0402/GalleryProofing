require "RMagick"
require 'watermark_image'
class Brand < ActiveRecord::Base
  include WatermarkImage

  attr_accessor :brand

  belongs_to :user
  has_many :contacts, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :galleries, dependent: :destroy
  has_many :gallery_layouts, dependent: :destroy
  has_many :email_templates, dependent: :destroy
  has_many :automation_series, dependent: :destroy
  has_one :studio_home_page, dependent: :destroy
  has_many :color_logos, dependent: :destroy
  has_many :refer_friends, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :invoices,dependent: :destroy
  has_many :invoice_line_items,dependent: :destroy
  has_many :watermarks,dependent: :destroy
  has_many :client_contacts,dependent: :destroy
  has_many :notifications,dependent: :destroy
  has_many :mobileapps,dependent: :destroy

  has_many :checkouts,dependent: :destroy

  belongs_to :primary_country, class_name: 'Country', foreign_key: 'primary_country_id'
  belongs_to :brand_country, class_name: 'Country', foreign_key: 'brand_country_id'

  validates :brand_name, presence: {:message => 'Please enter brand name for brand details.'}
  validates :website_url, presence: {:message => 'Please enter website url  for brand details.'}, if: lambda {|website_url| brand.present?}
  validates :email, presence: {:message => 'Please enter email for brand contact.'}
  validates :phone_number, presence: {:message => 'Please enter phone number for brand contact.'}, if: lambda {|phone_number| brand.present?}
  validates :address1, presence: {:message => 'Please enter address for brand contact.'}, if: lambda {|address1| brand.present?}
  validates :city, presence: {:message => 'Please enter city for brand contact.'}, if: lambda {|city| brand.present?}
  validates :pincode, presence: {:message => 'Please enter pincode for brand contact.'}, if: lambda {|pincode| brand.present?}
  validates :pincode, length: { maximum: 10, too_long: "Please enter valid postal code."}, if: lambda {|pincode| brand.present?}
  validates :pincode, format: { with: /\A[a-z0-9\-_]+\z/i, message: "Enter a valid postal code." }, if: lambda {|pincode| brand.present?}



  # validates_email_realness_of :email

  after_create :create_requirements

  #scope
  scope :get_default_brand , -> {find_by(:default => :true)}

  def create_requirements
    if self.brand_name.present?
      color_logo = ColorLogo.create!(name: "White with Gray", font_set: "A - Branadon, Baskerville", theme: "Light", primary_color: "#4d4d4d", secondary_color: "#3f8bb3", brand_id: self.id)
      puts color_logo

      gallery_layout = GalleryLayout.create!(name: self.brand_name, introduction_page_layout: "LimeLight",photo_page_layout: "Cascade",status: "Active",gallery_access_privacy: "public_no_password",pickup_option: "From Studio", brand_id: self.id, user_id: self.user_id, is_default: true, color_logo_id: color_logo.id)
      puts gallery_layout

      @shoot_proof_homepage =  StudioHomePage.find_by(subdomain: self.brand_name.downcase)
      if @shoot_proof_homepage.present?
        subdomain = self.brand_name.downcase + Random.rand(0...11111).to_s
        home_page = StudioHomePage.create!(subdomain: subdomain.downcase, color_logo_id: color_logo.id,homepage_layout: "Galleries", event_list: false, email_field: false, sort_on: "Gallery Shoot Date, Newest First", show_about: false, show_address: false, show_phone: false, show_email: false, show_website_link: false, brand_id: self.id)
      else
        home_page = StudioHomePage.create!(subdomain: self.brand_name.downcase, color_logo_id: color_logo.id,homepage_layout: "Galleries", event_list: false, email_field: false, sort_on: "Gallery Shoot Date, Newest First", show_about: false, show_address: false, show_phone: false, show_email: false, show_website_link: false, brand_id: self.id)
      end
      puts home_page

      image1 = create_image_watermark("#{Rails.root}/app/assets/images/demo (1).jpg","Adler",\
          "Black",self.brand_name,30)
      image2 = create_image_watermark("#{Rails.root}/app/assets/images/demo.jpg","Adler",\
          "Black",self.brand_name,30)
      @watermark = Watermark.create!(brand_id: self.id, name: "Studio Watermark", text_name: self.brand_name, font_set: "Adler", color: "Black", text_opacity_value: 30, selected_as: true, is_default: true, is_first: true, watermark_image: image1, watermark_sample_image: image2)
    end
  end
end
