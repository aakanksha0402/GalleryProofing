class PlansBillingsController < ApplicationController
  before_filter :authenticate_user!
  def planbilling
    if @current_user_permissions.find_by(permission_name: "View Administration").value == false
      @not_authorized = true
    end
    @current_user = current_user
    @data_plans = DataPlan.where(data_period: "Monthly").order(:id)
    @dp = DataPlan.where(data_period: "Yearly").order(:id)
    @plan_and_billing = @current_user.plan_billing
    @current_plan = @plan_and_billing.data_plan
    @transactions = @current_user.transaction_summaries
  end

  def changeplan
    if @current_user_permissions.find_by(permission_name: "Edit Administration").value == false
      @not_authorized_to_edit = true
      render :planbilling
    else
      @customer = current_user
      @customer_id = @customer.customer_id
      @current_plan = DataPlan.joins(:plan_billing => :user).where("users.id = ? " , @customer.id).first
      @change_plan = DataPlan.find(params[:photo_plan_id])
      @plan_billing = @customer.plan_billing
      if @plan_billing.billing_date >= Date.today && @customer_id.present?
        puts params[:photo_plan_id]
        if @change_plan.id == 1
          @credit = @customer.transaction_summaries.last.credit + @current_plan.plan_price.to_d
          if @change_plan.data_period == "Monthly"
            billing_date = Date.today + 30
          elsif @change_plan.data_period == "Yearly"
            billing_date = Date.today + 30
          end
          @plan_change = @plan_billing.update(data_plan_id: @change_plan.id, billing_date: billing_date)
          @transaction = TransactionSummary.create(user_id: @current_user.id, amount: 0.00, description: "Photo Plan", message: "authorized", success: true, transaction_id: "No Transaction", credit: @credit)
        else
          @transaction = @change_plan.change_plan(@customer)
        end
        redirect_to plans_billings_planbilling_path, notice: "Plan succesfully changed"
      elsif @plan_billing.billing_date > Date.today
        if @change_plan.data_period == "Monthly"
          billing_date = Date.today + 30
        elsif @change_plan.data_period == "Yearly"
          billing_date = Date.today + 30
        end
        @plan_change = @plan_billing.update(data_plan_id: @change_plan.id, billing_date: billing_date)
        redirect_to plans_billings_planbilling_path, notice: "Plan succesfully changed"
      else
        if @customer_id.present?
          puts params[:photo_plan_id]
          if @change_plan.id == 1
            @credit = @customer.transaction_summaries.last.credit + @current_plan.plan_price.to_d
            @plan_change = @plan_billing.update(data_plan_id: @change_plan.id)
            @transaction = TransactionSummary.create(user_id: @current_user.id, amount: 0.00, description: "Photo Plan", message: "authorized", success: true, transaction_id: "No Transaction", credit: @credit)
          else
            @transaction = @change_plan.change_plan(@customer)
          end
          redirect_to plans_billings_planbilling_path, notice: "Plan succesfully changed"
        else
          redirect_to plans_billings_creditcard_path
        end
      end
    end
  end

  def creditcard
    if @current_user_permissions.find_by(permission_name: "View Administration").value == false
      @not_authorized = true
    else
      @customer_id = current_user.customer_id.present?
      @client_token = Braintree::ClientToken.generate
    end

  end

  def chargecreditcard
    @current_user = current_user
    @plan_billing = @current_user.plan_billing
    nonce_from_the_client = params[:payment_method_nonce]
    result = Braintree::Customer.create(
        first_name: current_user.firstname,
        last_name: current_user.lastname,
        payment_method_nonce: nonce_from_the_client
      )
    if result.success? == true
      @current_user.update(customer_id: result.customer.id)
      @data_plan = DataPlan.find(@current_user.plan_billing.data_plan_id)
      @transaction = @data_plan.save_transaction(@current_user)
      redirect_to plans_billings_creditcard_path, notice: "Credit Card Saved Successfully"
    else
      redirect_to plans_billings_creditcard_path, notice: "There was an error saving your card"
    end
  end

  def print_invoice
    @transaction = TransactionSummary.find(params[:bill_id])
  end
end
