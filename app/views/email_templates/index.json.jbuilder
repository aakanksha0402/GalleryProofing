json.array!(@email_templates) do |email_template|
  json.extract! email_template, :id, :name, :email_subject, :headline, :button_text, :email_body, :default_email_template_id, :brand_id
  json.url email_template_url(email_template, format: :json)
end
