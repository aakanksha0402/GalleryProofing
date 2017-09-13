class ClientviewMailer < ApplicationMailer

  def clientview_email(gallery_id,email)
    @gallery_id = gallery_id
    @gallery = Gallery.find(gallery_id)
    @email = email
    @gallery_visitor = GalleryVisitor.where("gallery_id = ? AND email = ?", @gallery_id, @email).first
    # attachments.inline[@gallery.cover_url.original_filename] = File.read(@gallery.cover_url.path)
    mail(to: email, subject: 'Link to download your photos')

  end
end
