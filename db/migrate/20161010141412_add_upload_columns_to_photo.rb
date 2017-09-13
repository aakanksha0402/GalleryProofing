class AddUploadColumnsToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :upload_watrmark, :boolean
  end
end
