class OrderMailer < ApplicationMailer
	helper :application

  def order_email(email,message,order)
    @message = message
    @order = Order.find(order)
    mail(to: email, subject: 'Your order has been placed!')
  end
	
end
