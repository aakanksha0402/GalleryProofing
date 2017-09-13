FactoryGirl.define do
  factory :add_payment do
    invoice nil
    payment_with nil
    payment_date "2016-07-19"
    amount "9.99"
    cheque_no 1
    memo "MyText"
  end
end
