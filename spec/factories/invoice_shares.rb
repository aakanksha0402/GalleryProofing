FactoryGirl.define do
  factory :invoice_share do
    recipient "MyString"
    subject "MyString"
    headline "MyString"
    buttontext "MyString"
    message "MyString"
    email_template nil
    invoice nil
  end
end
