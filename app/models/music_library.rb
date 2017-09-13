class MusicLibrary < ActiveRecord::Base
  #Associations
  has_many :user_musics, dependent: :destroy

  # PaperClip Validations
  has_attached_file :music
  validates_attachment_content_type :music, content_type: [ 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio' ]

  has_attached_file :photo
  validates_attachment :photo, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"]}, style: {thumb: "77x77"}

  #Scopes for search
  scope :singer, lambda{|singer| where("singer ILIKE ?", "%#{singer}%")}
  scope :title, lambda{|title| where("title ILIKE ?","%#{title}%")}
end
