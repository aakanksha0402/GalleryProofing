class Country < ActiveRecord::Base
  has_many :contacts
  has_many :state_provinces
  has_many :client_contacts
  has_many :brands
end
