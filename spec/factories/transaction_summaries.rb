FactoryGirl.define do
  factory :transaction_summary do
    user nil
    description "MyString"
    amount "9.99"
    message "MyString"
    success false
    transaction_id "MyString"
    customer_first_name "MyString"
    customer_last_name "MyString"
    processor_authorization_code "MyString"
    processor_authentication_text "MyString"
    last4 "MyString"
    card_token "MyString"
    card_type "MyString"
    unique_number_identifier "MyString"
  end
end
