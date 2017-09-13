class DataPlan < ActiveRecord::Base
  has_one :plan_billing, dependent: :destroy

  def save_transaction(customer)
    @customer = customer
    result = transaction(customer,self.plan_price, self.id, 0.00)
  end

  # def change_plan(customer)
  #   @total_days = Time.days_in_month(Date.today.day)
  #   @customer = customer
  #   transaction = @customer.transaction_summaries.last
  #   @plan_billing = @customer.plan_billing
  #   # transaction_credit = transaction.credit
  #   if transaction.credit == 0
  #     credit = 0.00
  #   else
  #     credit = (@plan_billing.billing_date - Date.today).to_i*((transaction.amount)/30).to_f
  #   end
  #   paid_price = transaction.amount
  #   change_plan_price = self.plan_price.to_d
  #   if change_plan_price >= (paid_price + credit)
  #     puts "YO"
  #     if @plan_billing.billing_date > Date.today
  #       @credit = paid_price + credit
  #       @amount = change_plan_price - @credit
  #     else
  #       @credit = credit
  #       @amount = change_plan_price - @credit
  #     end
  #     if @amount > 0
  #       result = transaction(customer, @amount, self.id, @credit)
  #     else
  #       puts "YO INSIDE"
  #       @credit = credit - change_plan_price
  #       @transaction = TransactionSummary.create(user_id: @customer.id, amount: 0.00, description: "Photo Plan", message: "authorized", success: true, transaction_id: "No Transaction", credit: @credit)
  #       @plan_change = @plan_billing.update(data_plan_id: self.id)
  #     end
  #   elsif change_plan_price <= (paid_price + credit)
  #     puts "NO"
  #     puts credit
  #     @credit = (change_plan_price - (paid_price + credit)).abs.to_d
  #     if credit > @credit
  #       @amount = credit - @credit
  #     else
  #       @amount = self.plan_price.to_d - (paid_price + credit)
  #     end
  #     if @amount > 0
  #       result = transaction(customer, @amount, self.id, @credit)
  #     else
  #       puts "YO INSIDE"
  #       @transaction = TransactionSummary.create(user_id: @customer.id, amount: 0.00, description: "Photo Plan", message: "authorized", success: true, transaction_id: "No Transaction", credit: @credit)
  #       @plan_change = @plan_billing.update(data_plan_id: self.id)
  #     end
  #   end
  # end

  def change_plan(user)
    @user = user
    @current_plan = @user.plan_billing
    current_plan = DataPlan.find(@current_plan.data_plan_id)
    transaction = @user.transaction_summaries.last
    credit = transaction.credit
    transaction_amount = transaction.amount
    new_plan = self
    day_diff = (@current_plan.billing_date - Date.today).to_i
    day_price = (current_plan.plan_price.to_f/30)

    remaining_credit = day_diff * day_price
    total_credit = credit + remaining_credit
    # payable_amount = current_plan.plan_price.to_f - total_credit

    puts total_credit: total_credit.to_f
    # payable = self.plan_price.to_f - (current_plan.plan_price.to_f + total_credit)
    payable = self.plan_price.to_f - total_credit

    puts payable: payable.to_f

    if payable < 0
      final_credit = payable.abs
      amount = 0.00
    else
      final_credit = 0.00
      amount = payable
    end
    puts credit: final_credit.to_f
    puts amount: amount.to_f
    result = transaction(@user,amount, self.id, final_credit)
  end

  def transaction(customer, amount, plan_id, credit)
    puts AMOUNT: amount
    @credit = credit
    @customer = customer
    @billing = @customer.plan_billing
    if amount.to_f > 0
      result = Braintree::Transaction.sale(
        amount: amount,
        customer_id: @customer.customer_id,
        options: {
          store_in_vault_on_success: true
        }
      )
      if result.success? == true
        @transaction = TransactionSummary.create!(user_id: @customer.id, description: "Photo Plan", amount: result.transaction.amount, message: result.transaction.status, success: result.success?, transaction_id: result.transaction.id, card_token: result.transaction.credit_card_details.token, last4: result.transaction.credit_card_details.last_4, card_type: result.transaction.credit_card_details.card_type, processor_authorization_code: result.transaction.processor_authorization_code, processor_authentication_text: result.transaction.processor_response_text, credit: @credit)
        if self.data_period == "Monthly"
          billing_date = Date.today + 30
        elsif self.data_period == "Yearly"
          billing_date = Date.today + 30
        end
        @plan_change = @billing.update(data_plan_id: plan_id, billing_date: billing_date)
      else
        @transaction = TransactionSummary.create!(user_id: @customer.id, description: "Photo Plan", amount: 0.00, message: result.transaction.status, success: result.success?, credit: @credit)
        return false
      end
    else
      if self.data_period == "Monthly"
        billing_date = Date.today + 30
      elsif self.data_period == "Yearly"
        billing_date = Date.today + 30
      end
      @plan_change = @billing.update(data_plan_id: plan_id, billing_date: billing_date)
      @transaction = TransactionSummary.create!(user_id: @customer.id, description: "Photo Plan", amount: 0.00, message: "authorized", success: true, transaction_id: "nil", credit: @credit)
    end
    return
  end

end
