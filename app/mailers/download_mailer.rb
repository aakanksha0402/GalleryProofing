class DownloadMailer < ApplicationMailer

 def selected_download_email(user, bundle)
   @current_user = user
   @bundle = bundle
   mail(to: @current_user.email, subject: '	Zip file of photos from Event: gallery')
 end
end
