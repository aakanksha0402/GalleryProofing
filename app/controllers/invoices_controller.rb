class InvoicesController < ApplicationController
  require "active_merchant/billing/rails"

  before_action :set_invoice, only: [:show, :edit, :update, :destroy, :cancel_invoice]
  before_action :add_payment_details, only: [:save_payment]
  after_action  :add_notification, only: [:create]
  # GET /invoices
  # GET /invoices.json
  def index
    @invoices = current_brand.invoices.where(is_template: false).order(id: :asc)
    @plan_billing = PlanBilling.find_by(user_id: current_brand.user_id)
    @contacts = current_brand.client_contacts.all
    @status = Status.all

    puts "client name and email"
    @invoices = @invoices.client_name_email(params[:client_name_email]) if params[:client_name_email].present?
    puts "item name and description"
    @invoices = @invoices.item_name_description(params[:item_name_desc]) if params[:item_name_desc].present?
    puts "invoices number"
    @invoices = @invoices.invoice_number(params[:invoice_no]) if params[:invoice_no].present?
    puts "invoice_status"
    @invoices = @invoices.invoice_status(params[:invoice_status_id]) if params[:invoice_status_id].present?


    @invoice_email = InvoiceEmail.new
    # puts @invoices.as_json
  end

  # GET /invoices/1
  # GET /invoices/1.json
  def show
  end

  # GET /invoices/new
  def new
    if params[:template_id].present?
      @invoice = Invoice.find(params[:template_id])
    else
      @invoice = Invoice.new
      @invoice.invoice_line_items.build
    end

    @country = current_brand.brand_country
    @state_province = StateProvince.where(country_id: @country)
  end

  # GET /invoices/1/edit
  def edit
    @invoice_shares=InvoiceShare.new
    @client_contact = @invoice.client_contact.email
    @current_brand_name = current_brand.brand_name

    @status = Status.find(@invoice.status_id)
    @client_contact = ClientContact.find(@invoice.client_contact_id)
    @state_province = StateProvince.where(country_id: @client_contact.country_id)
    @add_payment = AddPayment.new
    @invoice_line_items = @invoice.invoice_line_items
    puts "_____________________"
    puts @invoice_line_items.as_json
    puts "_____________________"
  end

  def send_invoice_email
    @invoice_share = InvoiceShare.create(invoice_share_params)
    @invoice_share.save
    InvoiceShareMailer.send_invoice(@invoice_share).deliver_now!
    redirect_to edit_invoice_path(id: @invoice_share.invoice_id)
  end
  # POST /invoices
  # POST /invoices.json
  def create
    @invoice = Invoice.new(invoice_params)
    @invoice.brand_id = current_brand.id
    puts params
    if params[:contact_id].present?
      puts "Present"
      @contact = Contact.find(params[:contact_id])
      @client_contact = ClientContact.new((@contact.as_json).except("id","phone_number","pincode","notes","vendor","buisinessname","referredby"))
      @client_contact.postal_code = @contact.pincode
      @client_contact.phone = @contact.phone_number
      @client_contact.business_name = @contact.buisinessname
      @client_contact.note = @contact.notes
      @client_contact.contact_id = @contact.id
      @client_contact.save
    else
      puts "Not Present"
      @client_contact = ClientContact.new(firstname: params[:first_name],lastname: params[:last_name],email: params[:email],phone: params[:phone_number],address1: params[:address1],address2: params[:address2],city: params[:city],postal_code: params[:pincode],brand_id: current_brand.id,country_id: params[:client_contact][:country_id],state_province_id: params[:client_contact][:state_province_id])
      @client_contact.save
      puts "____________"
      puts (@client_contact.as_json).except("phone","postal_code","business_name","note","contact_id")
      @contact = Contact.new(firstname: @client_contact.firstname,lastname: @client_contact.lastname,email: @client_contact.email,country_id: @client_contact.country_id,pincode: @client_contact.postal_code,phone_number: @client_contact.phone,buisinessname: @client_contact.business_name,brand_id: @client_contact.brand_id,notes: @client_contact.note,address1: @client_contact.address1,address2: @client_contact.address2,state_province_id: @client_contact.state_province_id)
      # @contact = Contact.new((@client_contact.as_json).except("phone","postal_code","business_name","note","contact_id"))
      # @contact.phone_number = @client_contact.phone
      # @contact.pincode = @client_contact.postal_code
      # @contact.notes = @client_contact.note
      @contact.save
    end
    @invoice.client_contact_id = @client_contact.id
    respond_to do |format|
      if @invoice.save
        format.html { redirect_to invoices_path(id: current_user.id), notice: 'Invoice was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1
  # PATCH/PUT /invoices/1.json
  def update
    @invoice_shares=InvoiceShare.new
    puts params
    @issue_date = DateTime.parse(params[:invoice][:issue_date])
    puts @issue_date.class
    @due_date = DateTime.parse(params[:invoice][:final_due_date])
    puts @due_date.class
    respond_to do |format|
        puts "Possible"
        @invoice.invoice_line_items.destroy_all
        if @due_date >= @issue_date && @invoice.update(invoice_params)
          puts "===========if"
          @invoice_line_items = InvoiceLineItem.where(invoice_id: @invoice.id)
          @sub_total = 0
          @grand_total = 0
          @invoice_line_items.each do |invoice_line_item|
              @var = invoice_line_item.calculations
             invoice_line_item.update(total_price: @var[0],tax: @var[1])
             if invoice_line_item.tax.nil?
               @grand_total = @grand_total + invoice_line_item.total_price
             else
               @grand_total = @grand_total + invoice_line_item.total_price + invoice_line_item.tax
             end
             @sub_total = @sub_total + invoice_line_item.total_price
          end
          @invoice.update(grand_total: @grand_total,sub_total: @sub_total)
          if @invoice.deposit_type_id.present?
            if @invoice.deposit_type_id == 1
              @invoice.update(deposit: @invoice.grand_total*@invoice.deposit_amount/100)
            else
              @invoice.update(deposit: @invoice.deposit_amount)
            end
          end
          @client_contact = ClientContact.find(@invoice.client_contact_id)
          @client_contact.update_attributes(address1: params[:address1], address2: params[:address2], country_id: params[:client_contact][:country_id],state_province_id: params[:client_contact][:state_province_id],postal_code: params[:postal_code],city: params[:city])
          if params[:update_contact_address] == "1"
            Contact.find(@client_contact.contact_id).update_attributes(address1: params[:address1], address2: params[:address2], country_id: params[:client_contact][:country_id],state_province_id: params[:client_contact][:state_province_id],pincode: params[:postal_code],city: params[:city])
          end
          format.html { redirect_to edit_invoice_path(id: @invoice.id), notice: 'Invoice was successfully updated.' }
          format.json { render :show, status: :ok, location: @invoice }
        else
          @status = Status.find(@invoice.status_id)
          @client_contact = ClientContact.find(@invoice.client_contact_id)
          @state_province = StateProvince.where(country_id: @client_contact.country_id)
          @add_payment = AddPayment.new
          @invoice_line_items = @invoice.invoice_line_items
          flash[:error] = "Final payment due date must be on or after the issued date."
          format.html { render :edit }
          format.json { render json: @invoice.errors, status: :unprocessable_entity }
        end

    end
  end

  # DELETE /invoices/1
  # DELETE /invoices/1.json
  def destroy
    # @invoice.destroy
    @invoice.update_attributes(is_deleted: true,status_id: 4)
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: 'Invoice was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def contact_suggestions
    puts "hello"
    puts params[:name]
    @contacts = Contact.where('brand_id = ? AND firstname ILIKE ? or lastname ILIKE ?',params[:id].to_i,"#{params[:name]}%","%#{params[:name]}%" )
    puts @contacts.as_json
    respond_to do |format|
      format.js
    end
  end
  def existing_contact
    puts params
    @contact = Contact.find(params[:id])
    puts @contact
    respond_to do |format|
      format.js
    end
  end

  def state_list
    puts params
    @state_province = StateProvince.where(country_id: params[:country_id])
    puts @state_province.as_json
    respond_to do |format|
      format.js
    end
  end


  def save_payment
    puts params
    if params[:add_payment][:payment_with] == "1"
      @payment = AddPayment.new(invoice_id: params[:invoice_id],payment_with_id: params[:add_payment][:payment_with],payment_date: params[:add_payment][:payment_date],cash_cheque_memo: params[:add_payment][:cash_cheque_memo],amount: params[:add_payment][:cash_amount])
    else
      @payment = AddPayment.new(invoice_id: params[:invoice_id],payment_with_id: params[:add_payment][:payment_with],payment_date: params[:payment_date],cash_cheque_memo: params[:add_payment][:cash_cheque_memo],amount: params[:add_payment][:credit_amount])
    end
    if @payment.save
      if params[:add_payment][:payment_with] != "1"
      puts "____________________________"
      puts @gateway_found.present?
      puts @gateway_found.name
      puts "____________________________"
      if @gateway_found.present?
        if @gateway_found.name == "Braintree"
          ActiveMerchant::Billing::Base.mode = :test
          gateway = ActiveMerchant::Billing::BraintreeGateway.new(
                      :merchant_id => @gateway_found.merchant_id,
                      :public_key  => @gateway_found.public_key,
                      :private_key => @gateway_found.private_key
                    )
          puts "================="
          credit_card = ActiveMerchant::Billing::CreditCard.new(
              :number     => params[:add_payment][:cc_num],
              :month      => params[:add_payment][:exp_month],
              :year       => params[:add_payment][:exp_year],
              :verification_value => params[:add_payment][:cc_cvs],
            )
          amount = @payment.amount  # $10.00
          response = gateway.purchase(amount, credit_card)
          puts response.as_json
          respond_to do |format|
            if response.success?
              @payment.update_columns({authorization: response.authorization, success: response.success?, message: response.message})
              puts "Successfully charged $#{sprintf("%.2f", amount / 100)} to the credit card #{credit_card.display_number}"
              format.html { redirect_to edit_invoice_path(id: params[:invoice_id]),notice: "Success" }
            else
              # raise StandardError, response.message
              puts response.params["braintree_transaction"]["processor_response_code"]
              puts "_________________"
              @payment.update_columns({authorization: response.authorization, success: response.success?, message: response.message})
              # format.html { redirect_to edit_invoice_path(id: params[:invoice_id]), notice: 'Invalid Card Details.' }
              format.js
              # raise StandardError, response.message
            end
          end
        elsif @gateway_found.name == "Pro"
          gateway = ActiveMerchant::Billing::PaypalGateway.new(
              :login => @gateway_found.user_name,
              :password => @gateway_found.password,
              :signature => @gateway_found.signature
            )
            credit_card = ActiveMerchant::Billing::CreditCard.new(
                :number     => params[:add_payment][:cc_num],
                :month      => params[:add_payment][:exp_month],
                :year       => params[:add_payment][:exp_year],
                :verification_value => params[:add_payment][:cc_cvs],
              )
            amount = @payment.amount  # $10.00
            response = gateway.purchase(amount, credit_card)
            puts response.as_json
            respond_to do |format|
              if response.success?
                @payment.update_columns({authorization: response.authorization, success: response.success?, message: response.message})
                puts "Successfully charged $#{sprintf("%.2f", amount / 100)} to the credit card #{credit_card.display_number}"
                format.html { redirect_to edit_invoice_path(id: params[:invoice_id]),notice: "Success" }
              else
                # raise StandardError, response.message
                puts response.params["braintree_transaction"]["processor_response_code"]
                puts "_________________"
                @payment.update_columns({authorization: response.authorization, success: response.success?, message: response.message})
                # format.html { redirect_to edit_invoice_path(id: params[:invoice_id]), notice: 'Invalid Card Details.' }
                format.js
                # raise StandardError, response.message
              end
            end
        end
      end
      else
        redirect_to root_path
      end
    end
  end

  def send_invoice
    puts params
    @client = ClientContact.find(params[:client_email_id])
    @invoice_email = InvoiceEmail.new(email_id: @client.email,email_template_id: params[:invoice_email][:email_template_id],subject: params[:invoice_email][:subject],headline: params[:invoice_email][:headline],button_text: params[:invoice_email][:button_text],message: params[:invoice_email][:message],invoice_id: params[:invoice_id])
    @invoice_email.save
    InvoiceEmailMailer.invoice_email_mailer(@invoice_email,current_brand.brand_name).deliver_now
    redirect_to invoices_path(id: current_brand.id)
  end


  def invoice_email
    puts params
    @client_contact = ClientContact.find(params[:client_id])
    respond_to do |format|
      format.js
    end
  end

  def line_item_suggestion
    puts params
    # @contacts = Contact.where('brand_id = ? AND firstname ILIKE ? or lastname ILIKE ?',params[:id].to_i,"#{params[:name]}%","%#{params[:name]}%" )
    @line_item_suggestion = InvoiceLineItem.where('brand_id = ? AND name ILIKE ?',current_brand.id,"%#{params[:name]}%")
    puts @line_item_suggestion.as_json
    respond_to do |format|
      format.js
    end
  end

  def existing_line_item
    puts params
    respond_to do |format|
      format.js
    end
  end
  def client_view
     @show_invoice = Invoice.find(params[:invoice_id])
     puts current_brand.primary_country
     @country = Country.find(current_brand.primary_country)

     @status = Status.find(@show_invoice.status_id)
  end

  private
    def add_notification
      @invoice.update(client_contact_id: @client_contact.id,brand_id: current_brand.id)
        @invoice_line_items = InvoiceLineItem.where(invoice_id: @invoice.id)
        @sub_total = 0
        @grand_total = 0
        @invoice_line_items.each do |invoice_line_item|
          puts "_____________________"
            @var = invoice_line_item.calculations
           invoice_line_item.update(total_price: @var[0],tax: @var[1],brand_id: @invoice.brand_id)
           if invoice_line_item.tax.present?
             @grand_total = @grand_total + invoice_line_item.total_price + invoice_line_item.tax
           else
             @grand_total = @grand_total + invoice_line_item.total_price
           end
           @sub_total = @sub_total + invoice_line_item.total_price
        end
        @invoice.update(grand_total: @grand_total,sub_total: @sub_total)
        if @invoice.deposit_type_id.present?
          if @invoice.deposit_type_id == 1
            @invoice.update(deposit: @invoice.grand_total*@invoice.deposit_amount/100)
          else
            @invoice.update(deposit: @invoice.deposit_amount)
          end
        end
        # if !params[:contact_id].present?

          if params[:invoice][:is_template] == "1"
            @not_a_template_invoice = @invoice.dup
            @not_a_template_invoice.is_template = false
            @not_a_template_invoice.save
          end
          notifications = Notification.new(id_from: @invoice.id,notification_from: "Invoice",\
            brand_id: @invoice.brand_id,first_name: @invoice.client_contact.firstname,\
            last_name: @invoice.client_contact.lastname,amount: @invoice.grand_total )
          notifications.save
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find(params[:id])
    end

    def add_payment_details
      @gateway_found = GatewaySetup.where(user_id: current_brand.user_id).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_params
      params.require(:invoice).permit(:brand_id, :client_contact_id, :automation_series_id, :color_logo_id, :issue_date, :final_due_date, :sales_label, :sales_rate, :notes_to_client, :deposit_type_id, :deposit_amount, :allow_payment_cash_cheque, :allow_payment_credit_card, :payment_confirmation_text,:is_template,:template_name, :cc_num, :exp_month, :exp_year, :cc_cvs ,invoice_line_items_attributes: [:name,:description,:quantity,:price,:is_taxable,:brand_id,:total_price,:display_order,:tax])
    end

    def invoice_share_params
      params.require(:invoice_share).permit(:subject, :recipient, :headline, :buttontext, :message, :invoice_id)
    end
end
