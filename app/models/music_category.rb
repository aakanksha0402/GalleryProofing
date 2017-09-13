class MusicCategory < ActiveRecord::Base
  has_many :musics, dependent: :destroy
  has_many :music_plans, dependent: :destroy
end
