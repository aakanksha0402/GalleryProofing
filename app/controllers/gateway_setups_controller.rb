class GatewaySetupsController < ApplicationController
  require 'active_merchant'
  before_action :set_gateway_setup, only: [:show, :edit, :update, :destroy]
  before_action :validate_month, only: [:setup]
  # GET /gateway_setups 
  # GET /gateway_setups.json
  def index
    @gateway_setups = GatewaySetup.all
  end

  # GET /gateway_setups/1
  # GET /gateway_setups/1.json
  def show
  end
  def setup
    gateway_setup = GatewaySetup.where(user_id: current_user.id).first
    # Use the TrustCommerce test servers
    ActiveMerchant::Billing::Base.mode = :test
    if gateway_setup.name == "Braintree"
      gateway = ActiveMerchant::Billing::BraintreeGateway.new(
                :merchant_id => gateway_setup.merchant_id,
                :public_key  => gateway_setup.public_key,
                :private_key => gateway_setup.private_key
              )
      credit_card = ActiveMerchant::Billing::CreditCard.new(
        :number     => params[:card_no],
        :month      => params[:date][:month],
        :year       => params[:date][:year],
        :verification_value => params[:cvs],
      )
       # ActiveMerchant accepts all amounts as Integer values in cents
    amount = 1000  # $10.00
    response = gateway.purchase(amount, credit_card)
    puts response
    respond_to do |format|
      if response.success?
        puts "Successfully charged $#{sprintf("%.2f", amount / 100)} to the credit card #{credit_card.display_number}"
        format.html { redirect_to test_setup_gateway_setups_url, notice: 'Your payment gateway credentials are set up correctly.' }
      else
        format.html { redirect_to test_setup_gateway_setups_url, notice: 'Your payment gateway credentials are not set up correctly.' }
        # raise StandardError, response.message
      end
    end
    else
      gateway = ActiveMerchant::Billing::PaypalGateway.new(
                :login => gateway_setup.user_name,
                :password => gateway_setup.password,
                :signature => gateway_setup.signature
              )

      credit_card = ActiveMerchant::Billing::CreditCard.new(
        :type               => params[:type],
        :number             => params[:card_no],
        :verification_value => params[:cvs],
        :month              => params[:date][:month],
        :year               => params[:date][:year]
      )
      respond_to do |format|
        response = gateway.purchase(1000, credit_card, :ip => "127.0.0.1")
        puts response.as_json
        if response.success?
          format.html { redirect_to test_setup_gateway_setups_url, notice: 'Your payment gateway credentials are set up correctly.' }
          puts "Purchase complete!"
        else
          format.html { redirect_to test_setup_gateway_setups_url, notice: 'Your payment gateway credentials are not set up correctly.' }
          # raise StandardError, response.message
        end
      end
    end

  end
  # GET /gateway_setups/new
  def new
    @gateway_found = GatewaySetup.where(user_id: current_user.id).first
    if @gateway_found
      @gateway_setup = @gateway_found
    else
      @gateway_setup = GatewaySetup.new
    end
  end

  # GET /gateway_setups/1/edit
  def edit
    respond_to do |format|
      format.js
    end
  end
  def test_setup
    @gateway_found = GatewaySetup.where(user_id: current_user.id).first
  end

  # POST /gateway_setups
  # POST /gateway_setups.json
  def create
    @gateway_setup = GatewaySetup.new(gateway_setup_params)

    respond_to do |format|
      if @gateway_setup.save
        format.html { redirect_to new_gateway_setup_url, notice: 'Gateway setup was successfully created.' }
        format.json { render :show, status: :created, location: @gateway_setup }
      else
        format.html { render :new }
        format.json { render json: @gateway_setup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gateway_setups/1
  # PATCH/PUT /gateway_setups/1.json
  def update
    respond_to do |format|
      if @gateway_setup.update(gateway_setup_params)
        format.html { redirect_to new_gateway_setup_url, notice: 'The payment gateway has been saved.' }
        format.json { render :show, status: :ok, location: @gateway_setup }
      else
        format.html { render :edit }
        format.json { render json: @gateway_setup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gateway_setups/1
  # DELETE /gateway_setups/1.json
  def destroy
    @gateway_setup.destroy
    respond_to do |format|
      format.html { redirect_to new_gateway_setup_url, notice: 'Gateway setup was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gateway_setup
      @gateway_setup = GatewaySetup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gateway_setup_params
      params.require(:gateway_setup).permit(:name, :public_key, :private_key, :environment, :merchant_id, :user_id,:user_name, :password, :signature, :secure_merchant_account_id)
    end
    def validate_month
      puts "LOLLLLLLLLLLLLLLLLLLLLLL"
      puts Time.now.month
      puts params[:date][:month]
      puts params[:date][:month].to_i < Time.now.month
      puts params[:date][:year]
      puts Time.now.year
      puts params[:date][:year].to_i == Time.now.year
      if (params[:date][:year].to_i == Time.now.year and params[:date][:month].to_i < Time.now.month)
        puts "KOLLLLLLLLLLLLLL"
        # errors.add(:exp_month, "can't be in the past")
        redirect_to test_setup_gateway_setups_path(type: params[:type],card_no: params[:card_no],cvs: params[:cvs],month: params[:date][:month],year: params[:date][:year]),:flash => { :error => "Please select a valid expiration date." }
      end

      # Raise error for expired card
      
    end
end
