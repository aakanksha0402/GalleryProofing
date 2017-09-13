FactoryGirl.define do
  factory :invoice do
    brand nil
    client_contact nil
    automation_series nil
    color_logo nil
    issue_date "2016-07-12"
    final_due_date "2016-07-12"
    sales_label "MyString"
    sales_rate "9.99"
    notes_to_client "MyText"
    discount_type nil
    deposit_amount "9.99"
    allow_payment_cash_cheque false
    allow_payment_credit_card false
    payment_confirmation_text "MyText"
  end
end
