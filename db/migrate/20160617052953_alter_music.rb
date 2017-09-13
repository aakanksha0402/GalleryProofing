class AlterMusic < ActiveRecord::Migration
  def up
    add_reference :musics, :music_category, index: true
    remove_column :musics, :music_plan_id
  end
  def down
    add_reference :musics, :music_plan, index: true
    remove_column :musics, :music_category_id
  end
end
