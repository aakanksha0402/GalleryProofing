FactoryGirl.define do
  factory :automation_series_email_template do
    automation_series nil
    email_template nil
    default_receipient_type nil
    default_trigger_type nil
    trigger_days 1
    template_name "MyString"
  end
end
