class AddPhotoIdToMobileapp < ActiveRecord::Migration
  def change
    add_column :mobileapps, :photo_id, :integer
  end
end
