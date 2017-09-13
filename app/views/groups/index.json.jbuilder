json.array!(@groups) do |group|
  json.extract! group, :id, :fix_group_id, :name, :is_deleted, :pricing_id
  json.url group_url(group, format: :json)
end
