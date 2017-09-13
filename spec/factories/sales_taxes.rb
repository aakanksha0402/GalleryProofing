FactoryGirl.define do
  factory :sales_tax do
    title "MyString"
    digital_charge false
    shipping_tax false
    tax_percent "9.99"
    vat "9.99"
    pricing nil
    is_deleted false
  end
end
