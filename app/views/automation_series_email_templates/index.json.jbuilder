json.array!(@automation_series_email_templates) do |automation_series_email_template|
  json.extract! automation_series_email_template, :id, :automation_series_id, :email_template_id, :default_receipient_type_id, :default_trigger_type_id, :trigger_days, :template_name
  json.url automation_series_email_template_url(automation_series_email_template, format: :json)
end
