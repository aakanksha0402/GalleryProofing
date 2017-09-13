class AddFlagToShareFavorite < ActiveRecord::Migration
  def change
    add_column :share_favorites, :flag, :boolean
  end
end
