class GalleryShareMailer < ApplicationMailer
  helper :galleries

  def gallery_share_mailer(recipient,current_brand)
    puts recipient.inspect
    @reciever = recipient
    @buttontext = recipient.buttontext
    @cover_url=Gallery.find_by(id: recipient.gallery_id)
    @gallery_cover_url=@cover_url.cover_url.url
    # puts "@@@@@@@@@@@@@#{recipient.gallery_id}@@@@@@@@@@"
    puts @gallery_cover_url
    @subject = recipient.subject
    @current_brand=current_brand
    @gallery=Gallery.find_by(id: recipient.gallery_id)
    @gallery_id =  Gallery.find_by(id: recipient.gallery_id).id
    #  puts "@@@@@@@@@@@@@#{@gallery_id}@@@@@@@@@@"

    mail(to: @reciever.recipient, subject: 'Welcome to My Awesome Site')
  end
end
