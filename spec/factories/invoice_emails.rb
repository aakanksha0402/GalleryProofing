FactoryGirl.define do
  factory :invoice_email do
    email_id "MyString"
    email_template nil
    subject "MyString"
    headline "MyString"
    button_text "MyString"
    message "MyText"
    invoice nil
  end
end
