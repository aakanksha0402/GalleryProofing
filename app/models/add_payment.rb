class AddPayment < ActiveRecord::Base
  require "active_merchant/billing/rails"

  ActiveMerchant::Billing::Base.mode = :test

  belongs_to :invoice
  belongs_to :payment_with


  scope :year,lambda {|year| where('extract(year from payment_date) = ? ', year )}

  attr_accessor :cc_num
  attr_accessor :exp_month
  attr_accessor :exp_year
  attr_accessor :cc_cvs

  def credit_card
    ActiveMerchant::Billing::CreditCard.new(
      number:              cc_num,
      verification_value:  cc_cvs,
      month:               exp_month,
      year:                exp_year
    )
  end

  def valid_card
    puts "called me"
    puts cc_num
    if !credit_card.valid?
      errors.add(:card, "is not valid. Try again.")
      puts "The card is not valid"
      false
    else
      true
    end
  end


  def braintree
    puts "caught here"
    if valid_card
      puts "---------Card is valid----------"
      brand_details = Brand.find(brand)
      gateway_setup = GatewaySetup.where(user_id: brand_details.user_id).first
      gateway = ActiveMerchant::Billing::BraintreeGateway.new(
        :merchant_id => gateway_setup.merchant_id,
        :public_key  => gateway_setup.public_key,
        :private_key => gateway_setup.private_key
      )
      response = gateway.purchase(amount.to_f * 100, credit_card, :ip => "127.0.0.1")
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

  def cash_amount
    self.amount
  end

  def credit_amount
    self.amount
  end

  def self.to_csv()
    attributes = %w{payment_date id amount cheque_no}
    CSV.generate(headers: true) do |csv|
      csv.add_row attributes
        all.each do |payment|
          csv.add_row attributes.map{ |attr| payment.send(attr) }
        end
    end
  end
end
