class AddFieldToMusicPlan < ActiveRecord::Migration
  def change
    add_reference :music_plans, :music_category, index: true, foreign_key: true
  end
end
