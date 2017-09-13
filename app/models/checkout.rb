class Checkout < ActiveRecord::Base
  require "active_merchant/billing/rails"

  after_create :create_notification

  belongs_to :gallery_visitor
  belongs_to :shipping_option

  belongs_to :brand
  belongs_to :checkout_status, class_name: 'CheckoutStatus', foreign_key: 'checkout_status_id'
  has_many :line_items, dependent: :destroy
  belongs_to :checkout_status

  attr_accessor :card
  attr_accessor :month
  attr_accessor :year
  attr_accessor :cvc
  attr_accessor :payment_option
  attr_accessor :payed_using
  attr_accessor :same_billing_address

  validates :cvc, presence: true, :if => lambda {|u| payment_option == "true" && payed_using != "PAYPALPAYMENTSTANDARD"}
  validates :card, presence: true, :if => lambda {|u| payment_option == "true"  && payed_using != "PAYPALPAYMENTSTANDARD"}
  validates :month, presence: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12 }, :if => lambda {|u| payment_option == "true"  && payed_using != "PAYPALPAYMENTSTANDARD"}
  validates :year, presence: true, numericality: { greater_than_or_equal_to: Time.now.year, less_than_or_equal_to: Time.now.year + 15 }, :if => lambda {|u| payment_option == "true"  && payed_using != "PAYPALPAYMENTSTANDARD"}
  validates :amount, presence: true

  validate :valid_card, :if => lambda {|u| payment_option == "true"  && payed_using != "PAYPALPAYMENTSTANDARD"}

  validates :email, :phone_number, :shipping_first_name, :shipping_last_name, :shipping_addr1, presence: true

  validates :billing_first_name, :billing_last_name, :billing_addr1, presence: true, :if => lambda {|u| same_billing_address == "0"}


  scope :order_year, lambda {|year| where('extract(year from checkouts.created_at) = ?',year)}
  scope :order_name, lambda{ |o| where("cast(checkouts.id as text) ILIKE ?", "%#{o}%") }
  # scope :gallery, lambda{ |g|  where("galleries.name LIKE ?", g)  }
  scope :f_l_name, lambda{ |f|  where("checkouts.shipping_first_name ILIKE ? or checkouts.shipping_last_name ILIKE ? ", "%#{f}%", "%#{f}%")  }
  scope :email, lambda{ |f|  where("email ILIKE ?", "%#{f}%")  }
  scope :status, lambda{ |s|  where("checkouts.status ILIKE ?", "%#{s}%")  }
  scope :gallery, lambda {|gallery_id| includes(:gallery_visitor).where('checkouts.gallery_visitor.gallery_id = ?', gallery_id.to_i)}
  scope :has_success, lambda { |has| has == "t" ? "YES" : "NO" }
 ransacker :has_success
  ActiveMerchant::Billing::Base.mode = :test

  def valid_card
    if !credit_card.valid?
      errors.add(:card, "is not valid. Try again.")
      puts "The card is not valid"
      false
    else
      true
    end
  end

  def credit_card
    ActiveMerchant::Billing::CreditCard.new(
      number:              card,
      verification_value:  cvc,
      month:               month,
      year:                year,
      first_name:          self.shipping_first_name,
      last_name:           self.shipping_last_name

    )
  end

  def braintree
    if valid_card
      puts "---------Card is valid----------"

      brand_details = Brand.find(self.brand_id)
      gateway_setup = GatewaySetup.where(user_id: brand_details.user_id).first
      gateway = ActiveMerchant::Billing::BraintreeGateway.new(
        :merchant_id => gateway_setup.merchant_id,
        :public_key  => gateway_setup.public_key,
        :private_key => gateway_setup.private_key
      )
      puts "gateway:------- #{gateway}"
      response = gateway.purchase(self.amount.to_f * 100, credit_card, :ip => "127.0.0.1")
      puts "------responce: ----------#{response.as_json}"
      if response.success?
         puts "--------------Success-------------"
         update_columns({authorization: response.authorization, success: response.success?, message: response.message})
         true
      else
        puts "------------Declined-------------"
        errors.add(:card, "The credit card you provided was declined.  Please double check your information and try again.") and return
        false
      end
    end
  end

  def paypal
    if valid_card
      puts "---------Card is valid----------"

      brand_details = Brand.find(self.brand_id)
      gateway_setup = GatewaySetup.where(user_id: brand_details.user_id).first
      gateway = ActiveMerchant::Billing::PaypalGateway.new(
          :login => gateway_setup.user_name,
          :password => gateway_setup.password,
          :signature => gateway_setup.signature
        )
      puts "gateway:------- #{gateway}"
      response = gateway.purchase(self.amount.to_f * 100, credit_card, :ip => "127.0.0.1")
      puts "------responce: ----------#{response.as_json}"
      if response.success?
         puts "--------------Success-------------"
         update_columns({authorization: response.authorization, success: response.success?, message: response.message})
         true
      else
        puts "------------Declined-------------"
        errors.add(:card, "The credit card you provided was declined.  Please double check your information and try again.") and return
        false
      end
    end
  end

  def create_notification
    notify = Notification.create!(id_from: self.id, notification_from: "Order",brand_id: self.brand_id,first_name: self.shipping_first_name, \
      last_name: self.shipping_last_name, amount: self.amount)
  end


  def checkout_values
    @vat = self.gallery_visitor.gallery.custom_gallery_layout.pricing.sales_tax.vat
    @albums = self.gallery_visitor.gallery.albums
    @line_items = self.line_items

    @albums.each do |album|
      @line_items.each do |line_item|
        if line_item.photo.imageable_type == "Album"
          @album_name = album.title
        end
      end
    end
    return @vat,@albums,@line_items,@album_name
  end


  def sales_cal(month)
    puts self.as_json
    puts "_______"
    puts month
    if self.created_at.month == month
      @sum = self.amount
      @vat = self.gallery_visitor.gallery.custom_gallery_layout.pricing.sales_tax.vat
    end
    puts "*******#{self.created_at.month}**#{month}*********"
    return @sum,@vat
  end

  def self.to_csv()
    attributes = %w{Ordered_Date Ordered_id Gallery Customer_Name Files_Ordered}
    CSV.generate(headers: true) do |csv|
      csv.add_row attributes
        all.each do |checkout|
          @file_name = []
          checkout.line_items.each do |a|
            @file_name << a.photo.image_file_name
          end
          csv.add_row [checkout.created_at.strftime('%d-%b-%Y'),checkout.id,checkout.gallery_visitor.gallery.name,"#{checkout.shipping_first_name} #{checkout.shipping_last_name}","#{@file_name.join(',')}"]
        end
    end
  end

  def self.csv()
    attributes = %w{Ordered_Date Ordered_id Gallery Album Customer_Name Total_sales Client_Sales_tax Client_Shipping}
    CSV.generate(headers: true) do |csv|
      csv.add_row attributes
        all.each do |checkout|
          @file_name = []
          checkout.line_items.each do |a|
            @file_name << a.photo.image_file_name
          end
          if checkout.checkout_values[3].nil?
           @album_name =  "-"
          else
            @album_name = checkout.checkout_values[3]
          end
          @shipping_options = ShippingOption.all
          @shipping_options.each do |shipping_option|
            if checkout.shipping_option_id == shipping_option.id
              @shipping = shipping_option.price
            end
          end
          @date = checkout.created_at.strftime('%d-%b-%Y')
          @gallery_name = checkout.gallery_visitor.gallery.name
          @id = checkout.id
          @full_name = checkout.shipping_first_name + checkout.shipping_last_name
          @amount = checkout.amount
          @tax = checkout.checkout_values[0]
          csv.add_row ["#{@date}","#{@id}","#{@gallery_name}","#{@album_name}","#{@full_name}","#{@amount}","#{@tax}","#{@shipping}"]
          # csv.add_row [checkout.created_at.strftime('%d-%b-%Y'),checkout.id,checkout.gallery_visitor.gallery.name,"#{@album_name}","#{checkout.shipping_first_name} #{checkout.shipping_last_name}",checkout.amount,checkout.checkout_values[0],"#{@shipping}"]
        end
    end
  end

  def self.sales_csv()
    attributes = %w{Month Total_sales Client_Sales_Tax Client_Shipping Lab_Product_Cost 	Lab_Addon_Costs Lab_Shipping Payment_Processing_Sale 	Payment_Processing_Voids/Refunds Payment_Processing_Fees 	Payment_Withdrawal_Fees}
    CSV.generate(headers: true) do |csv|
      csv.add_row attributes
      @array = all.pluck(:id)
      (1..Date.today.month).each do |month|
        @total_sales = 0
        @sales_tax = 0
        @shipping = 0
        all.order(id: :asc).each do |checkout|
          if checkout.created_at.month == month
            if @array.include?(checkout.id)
                puts @array
                @shipping_options = ShippingOption.all
                @shipping_options.each do |shipping_option|
                  if checkout.shipping_option_id == shipping_option.id
                    @shipping = @shipping + shipping_option.price.to_d
                  end
                end
                if !checkout.sales_cal(month)[0].nil?
                  @total_sales = @total_sales + checkout.sales_cal(month)[0].to_i
                end
                if !checkout.sales_cal(month)[1].nil?
                  @sales_tax = @sales_tax + checkout.sales_cal(month)[1].to_i
                end
                @array.delete(checkout.id)
            end
          end
        end
        csv.add_row [month,"#{@total_sales}","#{@sales_tax}","#{@shipping}",0,0,0,0,0,0,0]
          # csv.add_row [month,"#{@total_sales}"]
      end
    end
  end
end
