class StudioHomePage < ActiveRecord::Base
  has_one :color_logo
  belongs_to :brand

  validates :subdomain,presence: { message: "Please enter the subdomain for your brand." }
  validates :subdomain, uniqueness: { case_sensitive: true, message: "That subdomain is already in use, please choose a different one." }
  validates :subdomain, format: { with: /\A[a-z0-9]+\z/,
    message: "Please enter a valid subdomain for your brand. Subdomains may contain only letters and numbers." }
    
  LAYOUT = [["Galleries","Galleries"],["Category of Galleries","Category of Galleries"],["Widget","Widget"]]
  SORT = ["Gallery Shoot Date, Newest First", "Gallery Shoot Date, Oldest First", "A-Z", "Z-A"]
end
