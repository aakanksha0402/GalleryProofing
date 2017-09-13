json.array!(@default_email_template_types) do |default_email_template_type|
  json.extract! default_email_template_type, :id, :name
  json.url default_email_template_type_url(default_email_template_type, format: :json)
end
