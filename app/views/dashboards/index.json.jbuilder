json.array!(@dashboards) do |dashboard|
  json.extract! dashboard, :id, :show_video, :add_gallery, :upload_photos, :customize_watermark, :setup_colo_logo, :user_id
  json.url dashboard_url(dashboard, format: :json)
end
