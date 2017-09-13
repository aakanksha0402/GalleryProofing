json.array!(@data_plans) do |data_plan|
  json.extract! data_plan, :id, :photos_number, :mobile_apps_number, :invoices_number, :data_period, :plan_price
  json.url data_plan_url(data_plan, format: :json)
end
