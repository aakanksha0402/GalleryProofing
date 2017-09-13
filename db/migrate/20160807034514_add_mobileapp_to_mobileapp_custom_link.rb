class AddMobileappToMobileappCustomLink < ActiveRecord::Migration
  def change
    add_reference :mobileapp_custom_links, :mobileapp, index: true, foreign_key: true
  end
end
