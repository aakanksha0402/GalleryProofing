class ShareFavoriteMailer < ApplicationMailer
  helper :application

  def share_favorites(name, to_email, token, from_email, gallery, message,brand_id,gallery_visitor_id)
    @token = token
    @message = message
    @gallery_visitor_id = gallery_visitor_id
    @name = name
    @gallery_name = Gallery.find(gallery)
    @brand_id = brand_id
    mail(from: ShareFavorite.named_email(name, from_email), to: to_email, subject: "View my favorite photos from the #{@gallery_name.name} gallery!")
    rescue ActiveRecord::RecordNotUnique
    retry
  end
  
end
