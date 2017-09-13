class AddMobileappToMobileappPhoto < ActiveRecord::Migration
  def change
    add_reference :mobileapp_photos, :mobileapp, index: true, foreign_key: true
  end
end
