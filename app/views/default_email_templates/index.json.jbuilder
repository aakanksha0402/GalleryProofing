json.array!(@default_email_templates) do |default_email_template|
  json.extract! default_email_template, :id, :email_type, :email_subject, :headline, :button_text, :email_body
  json.url default_email_template_url(default_email_template, format: :json)
end
