class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  attr_accessor :sub_user

  validates :email, presence: { message: "Please enter the users email address" }

  validates :email, uniqueness: { message: "The email address is already in use, please choose a different one." }

  validates :password, presence: { message: "Please enter a password for the user", on: :create }

  validates :password, length: { maximum: 16, minimum: 6, message: "Password must be 6 letters long.", on: :create }

  validates :firstname, presence: { message: "Please enter a firstname for the user"}, if: lambda {|firstname| !sub_user.present?}

  validates :lastname, presence: { message: "Please enter a lastname for the user"}, if: lambda {|lasttname| !sub_user.present?}

  validates :studio_name, presence: { message: "Enter a Studio Name" }

  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    message: "Enter a valid Email Address" }

  # validates_email_realness_of :email

  validates :country_id, presence: { message: "Select a Country" }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable, :omniauth_providers => [:facebook]

  has_many :brands, dependent: :destroy
  has_many :galleries, dependent: :destroy
  has_many :gallery_layouts, dependent: :destroy
  has_many :pricings, dependent: :destroy
  has_one :gateway_setup, dependent: :destroy
  has_many :playlists, dependent: :destroy
  has_one :subscription, dependent: :destroy
  has_many :user_musics, dependent: :destroy
  has_one :dashboard, dependent: :destroy
  has_many :transaction_summaries, dependent: :destroy
  has_one :plan_billing, dependent: :destroy
  has_many :permissions, dependent: :destroy

  after_create :create_sub_requirements


  def create_sub_requirements
    if self.role == true
      dashboard = Dashboard.create!(user_id: self.id, show_video: true, show_get_paid: true, add_gallery: false, upload_photos: false, customize_watermark: false, setup_colo_logo: false)
      puts dashboard
      puts "user_id: #{self.id}"
      puts "email: #{self.email}"
      puts "brancd country id: #{self.country_id}"
      puts "country id: #{self.country_id}"
      puts "studio namae: #{self.studio_name}"
      puts "default: #{true}"

      brand = Brand.create!(user_id: self.id, brand_name: self.studio_name,primary_country_id: self.country_id, brand_country_id: self.country_id, default: true, email: self.email)
      if brand
        puts "blah"
      end
      puts brand
      plan_billing = PlanBilling.create!(user_id: self.id, billing_date: 30.days.from_now, data_plan_id: "3", credit: '0')
      puts plan_billing
        @var = PermissionActionPermissionSection.all
        @var.each do |var|
          permission = Permission.create!(permission_action_permission_section_id: var.id, value: true, user_id: self.id, permission_name: var.name)
        end
    end
  end

  def fullname
    "#{self.lastname}, #{self.firstname}"
  end

  def active_for_authentication?
    super && self.active?
  end

  def inactive_message
    "Account Not Valid"
  end

  def planbilling
    puts "plmplm"
  end
end
