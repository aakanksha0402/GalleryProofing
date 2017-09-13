FactoryGirl.define do
  factory :catalog do
    pricing nil
    type ""
    group nil
    fix_group nil
    checked false
    discription "MyText"
    cost "9.99"
    price "9.99"
    profit "9.99"
    shipping_charge "9.99"
    shipping_charge_apply false
    print_size_one 1.5
    print_size_two 1.5
    depth 1.5
    sub_item_name "MyString"
    is_deleted false
  end
end
