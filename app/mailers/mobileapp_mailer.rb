class MobileappMailer < ApplicationMailer

  def mobileapp_email(mobileapp_share,current_brand,brand_id,mobileapp)
    @mobileapp_share = mobileapp_share
    @current_brand = current_brand
    @mobileapp = mobileapp
    @brand_id = brand_id
    attachments.inline[@mobileapp.logo.original_filename] = File.read(@mobileapp.logo.path)
    @mobileapp_share.recipient.split(',').each do |email|
    	mail(to: email, subject: @mobileapp_share.subject)
		end
  end
	
end
