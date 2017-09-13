class Order < ActiveRecord::Base
  belongs_to :gallery
  belongs_to :brand
  scope :order_name, lambda{ |o| where("cast(orders.id as text) ILIKE ?", "%#{o}%") }
  # scope :gallery, lambda{ |g|  where("galleries.name LIKE ?", g)  }
  scope :f_l_name, lambda{ |f|  where("first_name ILIKE ? or last_name ILIKE ? ", "%#{f}%", "%#{f}%")  }
  scope :email, lambda{ |f|  where("email ILIKE ?", "%#{f}%")  }
  scope :status, lambda{ |s|  where("orders.status ILIKE ?", "%#{s}%")  }
   # scope :lab, lambda{ |l|  where("lab LIKE ?", l)  }

  def paid_value
   paid ? 'Yes' : 'No'
  end

end
