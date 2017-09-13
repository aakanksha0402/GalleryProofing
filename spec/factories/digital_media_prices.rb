FactoryGirl.define do
  factory :digital_media_price do
    indiviual_photo_price 1
    individual_price_active false
    all_album_photo_price 1
    all_album_price_active false
    all_gallery_photo_price 1
    all_gallery_price_active false
    catalog nil
  end
end
