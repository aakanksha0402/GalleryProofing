class Favorite < ActiveRecord::Base
  belongs_to :gallery_visitor
  belongs_to :photo

  require 'securerandom'

  def self.getTokenForShare
    SecureRandom.urlsafe_base64
  end
end
