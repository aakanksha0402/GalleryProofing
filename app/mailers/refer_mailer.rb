class ReferMailer < ApplicationMailer
  helper :application

  def refer_a_friend(refer, brand_name)
    @current_brand_name = brand_name
    @refer_details = refer
    mail(to: refer.email_address, subject: "Check Out Next Proof")
  end
  
end
