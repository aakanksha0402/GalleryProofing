class StateProvince < ActiveRecord::Base
  belongs_to :country
  has_many :contacts
end
