class CreateDashboards < ActiveRecord::Migration
  def change
    create_table :dashboards do |t|
      t.boolean :show_video
      t.boolean :add_gallery
      t.boolean :upload_photos
      t.boolean :customize_watermark
      t.boolean :setup_colo_logo
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
