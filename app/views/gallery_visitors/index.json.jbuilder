json.array!(@gallery_visitors) do |gallery_visitor|
  json.extract! gallery_visitor, :id, :email, :gallery_id
  json.url gallery_visitor_url(gallery_visitor, format: :json)
end
