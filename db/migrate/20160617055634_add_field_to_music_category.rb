class AddFieldToMusicCategory < ActiveRecord::Migration
  def change
    add_column :music_categories, :svg, :string
  end
end
