FactoryGirl.define do
  factory :checkout do
    cart nil
    shipping_method "MyString"
    email "MyString"
    phone_number "MyString"
    shipping_first_name "MyString"
    shipping_last_name "MyString"
    shipping_addr1 "MyString"
    shipping_addr2 "MyString"
    shipping_country_id "MyString"
    shipping_city "MyString"
    shipping_state "MyString"
    shipping_postal_code "MyString"
    payment_option "MyString"
    billing_first_name "MyString"
    billing_last_name "MyString"
    billing_addr1 "MyString"
    billing_addr2 "MyString"
    billing_country_id "MyString"
    billing_city "MyString"
    billing_state "MyString"
    billing_postal_code "MyString"
    shipping_option nil
    notes_to_studio "MyString"
    agree_to_terms false
    total_price "MyString"
  end
end
