class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true, foreign_key: true
      t.string :photo_subscription_id
      t.string :music_subscription_id

      t.timestamps null: false
    end
  end
end
