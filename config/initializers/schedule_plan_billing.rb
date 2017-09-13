require 'rubygems'
require 'rufus/scheduler'

scheduler = Rufus::Scheduler::new

scheduler.every '24h' do
	# do stuff
  puts "yo"
  User.all.each do |user|
    user_plan = user.plan_billing
    @current_plan = DataPlan.find(user_plan.data_plan_id)
    if user_plan.billing_date <= Date.today
      if user.customer_id.present?
        puts "CUSTOMER ID IS PRESENT"
        puts "DATA PLAN ID IS #{@current_plan.id}"
        if user_plan.data_plan_id == 1
          if @current_plan.data_period == "Monthly"
            billing_date = Date.today + 30
          elsif @current_plan.data_period == "Yearly"
            billing_date = Date.today + 365
          end
          @credit = user.transaction_summaries.last.credit + @current_plan.plan_price.to_d
          @transaction = TransactionSummary.create(user_id: user.id, amount: 0.00, description: "Photo Plan", message: "authorized", success: true, transaction_id: "No Transaction", credit: @credit)
        else
          amount = @current_plan.plan_price.to_f - user.transaction_summaries.last.credit
          if amount <= 0
            final_amount = 0
            credit = amount.abs
            @transaction = TransactionSummary.create(user_id: user.id, amount: final_amount, description: "Photo Plan", message: "authorized", success: true, transaction_id: "No Transaction", credit: credit)
          else
            final_amount = amount
            credit = 0
            @transaction = @current_plan.transaction(user, final_amount, @current_plan.id, credit)
          end
        end
      else
        puts "CUSTOMER ID IS NOT PRESENT"
        puts "DATA PLAN ID IS #{@current_plan.id}"
        unless @current_plan.id == 1
          if @current_plan.data_period == "Monthly"
            billing_date = @current_plan.billing_date + 30
          elsif @current_plan.data_period == "Yearly"
            billing_date = @current_plan.billing_date + 365
          end
          user_plan.update(data_plan_id: 1, billing_date: billing_date)
        end
        puts "plan changed"
      end
    elsif user_plan.billing_date > Date.today
      puts "CUSTOMER ID NOT PRESENT"
      puts "PLAN NOT TO BE CHANGED"
    end
  end
end
