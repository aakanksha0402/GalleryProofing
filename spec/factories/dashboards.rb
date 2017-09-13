FactoryGirl.define do
  factory :dashboard do
    show_video ""
    add_gallery false
    upload_photos false
    customize_watermark false
    setup_colo_logo false
    user nil
  end
end
