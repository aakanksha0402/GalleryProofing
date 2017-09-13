namespace :new_seed do
  desc "Inserts the data into the DiscountType model"
  task insert_in_discount_type: :environment do
    discount_type_attributes = [
      {type_name: "Item",description: "Discount based on specific items or quantities of items added to a cart"},
      {type_name: "Group",description: "Discount based on items added from a certain group"},
      {type_name: "Package",description: "Discount based on a certain set of items and quantities"},
      {type_name: "BOGO",description: "Buy an item or quantity of items, get another item or quantity of items free or discounted"},
      {type_name: "Cart",description: "Discount based on the quantity or total of items in a cart"},
      {type_name: "Credit",description: "Give a shipping or dollar credit"}
    ]

    discount_type_attributes.each do |attribute|
      DiscountType.where(attribute).first_or_create
    end
  end

  desc "Inserts the data into the DiscountOffer model"
  task insert_in_discount_offer: :environment do
    discount_offer_attributes = [
      {offer: "off each selected item",value: "A"},
      {offer: "off each item",value: "B"},
      {offer: "each item free",value: "C"},
      {offer: "free shipping for each item",value: "D"},
      {offer: "Percentage off on each item",value: "E"},
      {offer: "total off",value: "F"},
    ]

    discount_offer_attributes.each do |attribute|
      DiscountOffer.where(attribute).first_or_create
    end
  end


  desc "Inserts the data into the DiscountOfferType model"
  task insert_in_discount_offer_type: :environment do
    discount_offer_type_attributes = [
      {discount_offer_id: 1,discount_type_id: 1},
      {discount_offer_id: 5,discount_type_id: 1},
      {discount_offer_id: 2,discount_type_id: 1},
      {discount_offer_id: 3,discount_type_id: 1},
      {discount_offer_id: 1,discount_type_id: 2},
      {discount_offer_id: 5,discount_type_id: 2},
      {discount_offer_id: 2,discount_type_id: 2},
      {discount_offer_id: 3,discount_type_id: 2},
      {discount_offer_id: 3,discount_type_id: 4},
      {discount_offer_id: 2,discount_type_id: 4},
      {discount_offer_id: 5,discount_type_id: 4},
      {discount_offer_id: 4,discount_type_id: 5},
      {discount_offer_id: 5,discount_type_id: 5},
      {discount_offer_id: 1,discount_type_id: 5},
      {discount_offer_id: 1,discount_type_id: 6},
      {discount_offer_id: 4,discount_type_id: 6},
      {discount_offer_id: nil,discount_type_id: 3}
    ]

    discount_offer_type_attributes.each do |attribute|
      DiscountOfferType.where(attribute).first_or_create
    end
  end

  desc "Insert into Status Table."
  task insert_in_status: :environment do
    status_attributes = [
      {status: 'Unpaid'},
      {status: 'Paid'},
      {status: 'Partially Paid'},
      {status: 'Canceled'},
      {status: 'Past Due'}
    ]
    status_attributes.each do |attribute|
      Status.where(attribute).first_or_create
    end
  end

  desc "Insert into Deposit Type"
  task insert_in_deposit_type: :environment do
    deposit_type_attributes = [
      {deposit_type: 'Percentage'},
      {deposit_type: 'Fixed Amount'}
    ]

    deposit_type_attributes.each do |attribute|
      DepositType.where(attribute).first_or_create
    end
  end

  desc "Insert into Payment With"
  task insert_into_payment_with: :environment do
    payment_with_attributes = [
      {mode: "Cash/Cheque"},
      {mode: "Credit"}
    ]

    payment_with_attributes.each do |attribute|
      PaymentWith.where(attribute).first_or_create
    end
  end

  desc "Inserts the data into the CheckoutStatus model"
  task insert_in_checkout_status: :environment do
    checkout_status_attributes = [
      {status: "new"},
      {status: "Pending"},
      {status: "Awaiting Studio"},
      {status: "Shipped"},
      {status: "Completed"},
      {status: "Approved"},
      {status: "Canceled"}
    ]

    checkout_status_attributes.each do |attribute|
      CheckoutStatus.where(attribute).first_or_create
    end
  end

  desc "Inserts the data into the DefaultEmailTemplateType model"
  task insert_in_default_email_template_type: :environment do
    default_email_template_types_attributes = [
      {name: "Gallery Templates"},
      {name: "Invoice Templates"},
      {name: "Internal Studio Email Templates"},
      {name: "Other Templates"}
    ]

    default_email_template_types_attributes.each do |attribute|
      DefaultEmailTemplateType.where(attribute).first_or_create
    end
  end

  desc "insert the privilege for old contact record in the database"
  task insert_privileges: :environment do
    @gallery=Gallery.all
    @gallery.each do |g|
      g.build_privilege(:gallery_id => g.id)
      g.save
    end
  end
end
