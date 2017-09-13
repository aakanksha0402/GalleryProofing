class CountryLab < ActiveRecord::Base
  belongs_to :country
  belongs_to :lab
end
