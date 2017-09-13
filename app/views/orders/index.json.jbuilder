json.array!(@orders) do |order|
  json.extract! order, :id, :email_id, :first_name, :last_name, :address, :city, :country, :pin, :phone_no, :notes_to_studio, :gallery_id, :studio_internal_notes, :status
  json.url order_url(order, format: :json)
end
