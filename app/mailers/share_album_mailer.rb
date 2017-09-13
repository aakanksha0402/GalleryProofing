class ShareAlbumMailer < ApplicationMailer

  def album_share_mailer(recipient,current_brand)
    @reciever = recipient
    @album_id = @reciever.album_id
    @gallery_id = @reciever.album.gallery_id
    @buttontext = @reciever.buttontext
    @cover_url = Album.find_by(id: @reciever.album_id)
    @album_cover_url=@cover_url.cover_url.url
    @subject = @reciever.subject
    @current_brand = current_brand
    @album = Album.find_by(id: recipient.album_id)
    mail(to: @reciever.recipient, subject: 'Welcome to My Awesome Site')
  end

end
