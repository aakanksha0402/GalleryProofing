FactoryGirl.define do
  factory :notification do
    notification_from "MyString"
    id_from 1
    brand nil
    is_dismiss false
  end
end
