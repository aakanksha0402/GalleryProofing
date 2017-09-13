class ClientContact < ActiveRecord::Base
  belongs_to :state_province
  belongs_to :country
  belongs_to :brand
  #not able to destroy multiple when giving association "has_one", so i have writtern "has_many"
  has_many :invoices,dependent: :destroy
end
