class RemoveCustomLinkFromGalleries < ActiveRecord::Migration
  def change
    remove_column :galleries, :custom_link, :string
  end
end
