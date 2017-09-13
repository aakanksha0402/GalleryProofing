class UserMusic < ActiveRecord::Base
  belongs_to :playlist
  belongs_to :music_library
  belongs_to :user
  validates :playlist_id, uniqueness: { scope: :music_library_id }
end
