class AddPriceToMusicPlan < ActiveRecord::Migration
  def change
    add_column :music_plans, :price, :string
  end
end
