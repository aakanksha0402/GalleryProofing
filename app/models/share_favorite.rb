class ShareFavorite < ActiveRecord::Base
  belongs_to :gallery_visitor

  validates :token, uniqueness: true

  def self.named_email(name,email)
    "#{name} #{email}"
  end
end
