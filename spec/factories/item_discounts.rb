FactoryGirl.define do
  factory :item_discount do
    discount_offer_type nil
    value "9.99"
    promocode "MyString"
    use_limit 1
    expiration_date "2016-06-16"
    quantity 1
    checkout_limit 1
    checkout_used 1
    is_automatic false
    pricing nil
  end
end
