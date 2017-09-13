class Playlist < ActiveRecord::Base
  belongs_to :user
  has_many :user_musics, dependent: :destroy

  validates :name, presence: true
end
