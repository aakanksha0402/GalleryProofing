FactoryGirl.define do
  factory :order do
    email_id "MyString"
    first_name "MyString"
    last_name "MyString"
    address "MyText"
    city "MyString"
    country "MyString"
    pin 1
    phone_no 1
    notes_to_studio "MyText"
    gallery nil
    studio_internal_notes "MyText"
    status "MyString"
  end
end
